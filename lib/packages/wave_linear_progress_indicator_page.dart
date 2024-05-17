import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';

class WaveIndicatorPainter extends CustomPainter {
  WaveIndicatorPainter({
    required this.repaint,
    required this.progressAnimation,
    required this.backgroundColor,
    required this.borderRadius,
    required this.waveWidth,
    required this.waveBackgroundColor,
    required this.waveStep,
    required this.waveColor,
  }) : super(repaint: Listenable.merge([repaint, progressAnimation]));

  final Animation<double> repaint;
  final Animation<double> progressAnimation;
  final Color backgroundColor;
  final double? borderRadius;
  final double waveWidth;
  final Color waveBackgroundColor;
  final double waveStep;
  final Color waveColor;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // 剪裁画布
    if (borderRadius != null && borderRadius! > 0) {
      canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(borderRadius!)));
    } else {
      canvas.clipRect(Offset.zero & size);
    }

    _drawWaves(canvas, size);

    // 把背景盖在波纹上
    _drawBG(canvas, size);
  }

  void _drawBG(Canvas canvas, Size size) {
    final progress = progressAnimation.value;
    final left = size.width * progress;
    _paint
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final rect = Offset(left, 0) & Size(size.width - left, size.height);
    canvas.drawRect(rect, _paint);
  }

  void _drawWaves(Canvas canvas, Size size) {
    canvas.save();
    // final progress = progressAnimation.value;
    // final width = size.width * progress;
    _paint
      ..color = waveBackgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, _paint);
    canvas.clipRect(Offset.zero & size);

    const angle = 20;
    _paint
      ..color = waveColor
      ..style = PaintingStyle.fill;
    final count = (size.width / (waveStep + waveWidth)).ceil();

    final height = size.height * 2.0;

    final realWidth = (waveWidth + waveStep) * count;
    final offset = -realWidth * repaint.value;
    canvas.translate(offset, 0);

    for (int i = 0; i < count * 2; i++) {
      var dx = (waveWidth + waveStep) * i;

      canvas.save();
      canvas.translate(dx + waveWidth / 2, 0);
      canvas.rotate(angle * pi / 180);

      canvas.drawRect(Offset(0, -(height - size.height) / 2) & Size(waveWidth, height), _paint);

      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WaveIndicatorPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.repaint != repaint ||
      oldDelegate.progressAnimation != progressAnimation ||
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.waveWidth != waveWidth ||
      oldDelegate.waveStep != waveStep ||
      oldDelegate.waveBackgroundColor != waveBackgroundColor ||
      oldDelegate.waveColor != waveColor;
}

class WaveLinearProgressIndicator extends ProgressIndicator {
  const WaveLinearProgressIndicator({
    super.key,
    required super.value,
    super.backgroundColor = const Color(0xFFECF4F2),
    super.color,
    this.minHeight,
    this.borderRadius = 18,
    this.waveWidth = 10,
    this.waveColor = const Color(0x21FFFFFF),
    this.waveBackgroundColor = const Color(0xFF71E4D6),
    this.waveStep = 8,
    this.labelDecoration,
    this.enableBounceAnimation = false,
  });

  /// The minimum height of the line used to draw the linear indicator.
  final double? minHeight;

  /// Rounded corners of the progress indicator
  final double? borderRadius;

  /// Width of wave
  final double waveWidth;

  /// Background color of the progress indicator
  final Color waveBackgroundColor;

  /// Spacing from wave to the next wave
  final double waveStep;

  /// Color of the spacing between waves
  final Color waveColor;

  /// Decoration of the progress label widget
  final Decoration? labelDecoration;

  /// Whether to turn on the bouncing animation effect
  final bool enableBounceAnimation;

  @override
  State<StatefulWidget> createState() => _WaveLinearProgressIndicatorState();
}

class _WaveLinearProgressIndicatorState extends State<WaveLinearProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  final GlobalKey _progressLabelKey = GlobalKey();

  Decoration get _labelDecoration {
    if (widget.labelDecoration != null) {
      return widget.labelDecoration!;
    }
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF9DF3E9),
          Color(0xFF71E4D6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(13),
    );
  }

  Color get _backgroundColor {
    final Color trackColor =
        widget.backgroundColor ?? _indicatorTheme.linearTrackColor ?? Theme.of(context).colorScheme.background;
    return trackColor;
  }

  double get _minHeight => widget.minHeight ?? _indicatorTheme.linearMinHeight ?? 9;

  double get _progressLabelHeight => _minHeight + 4.5 * 2;

  ProgressIndicatorThemeData get _indicatorTheme => ProgressIndicatorTheme.of(context);

  @override
  void initState() {
    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));
    _waveController.repeat();
    _progressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _progressAnimation = Tween(begin: widget.value).animate(_progressController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WaveLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldValue = oldWidget.value ?? 0;
    final newValue = widget.value ?? 0;
    if (widget.enableBounceAnimation) {
      double bouncingValue = newValue + (10 / 100) * ((newValue - oldValue) / (newValue - oldValue).abs());
      bouncingValue = bouncingValue.clamp(0, 1.0).toDouble();
      _progressAnimation = TweenSequence(<TweenSequenceItem<double>>[
        TweenSequenceItem(
          tween: Tween(begin: oldValue, end: bouncingValue).chain(CurveTween(curve: Curves.ease)),
          weight: 3 / 4,
        ),
        TweenSequenceItem(
          tween: Tween(begin: bouncingValue, end: newValue).chain(CurveTween(curve: Curves.ease)),
          weight: 1 / 4,
        ),
      ]).animate(_progressController);
    } else {
      _progressAnimation = Tween(begin: oldValue, end: newValue).animate(_progressController);
    }
    _progressController.forward(from: 0);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: _progressLabelHeight,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        // print('=======layout===$constraints');
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: _minHeight,
                  minWidth: double.infinity,
                ),
                child: CustomPaint(
                  painter: WaveIndicatorPainter(
                    repaint: _waveController,
                    progressAnimation: _progressAnimation,
                    backgroundColor: _backgroundColor,
                    borderRadius: widget.borderRadius,
                    waveWidth: widget.waveWidth,
                    waveBackgroundColor: widget.waveBackgroundColor,
                    waveStep: widget.waveStep,
                    waveColor: widget.waveColor,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class WaveLinearProgressIndicatorPage extends StatefulWidget {
  const WaveLinearProgressIndicatorPage({super.key});

  @override
  State<WaveLinearProgressIndicatorPage> createState() => _WaveLinearProgressIndicatorPageState();
}

class _WaveLinearProgressIndicatorPageState extends State<WaveLinearProgressIndicatorPage> {
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "wave_linear_progress_indicator",
      widgets: [
        WaveLinearProgressIndicator(
          value: _progress,
          enableBounceAnimation: true,
          waveColor: Colors.transparent,
          minHeight: 16,
          labelDecoration: BoxDecoration(color: Colors.transparent),
        ),
        const SizedBox(height: 20),
        StreamBuilder<double>(
            stream: _getDownloadProgress(),
            builder: (context, snapshot) {
              double progress = 0;
              if (snapshot.hasData) {
                progress = snapshot.data!;
              }
              return WaveLinearProgressIndicator(
                value: progress,
                // waveColor: Colors.orange,
              );
            }),
        const SizedBox(height: 20),
        WaveLinearProgressIndicator(
          value: _progress,
          enableBounceAnimation: true,
          waveColor: Colors.red,
          backgroundColor: Colors.grey[150],
          minHeight: 20,
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: _progress,
          minHeight: 10,
          backgroundColor: Colors.orange,
        ),
        const SizedBox(height: 20),
        Slider(
          value: _progress,
          onChanged: (value) {
            setState(() {
              _progress = value;
            });
          },
        ),
      ],
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: _increase,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: _decrease,
          tooltip: 'Decrease',
          child: const Icon(Icons.remove),
        )
      ],
    );
  }

  Stream<double> _getDownloadProgress() async* {
    final values = <double>[0, 0.1, 0.2, 0.3, 0.4, 0.45, 0.7, 0.85, 0.9, 0.95, 0.99, 1.0];
    for (final p in values) {
      yield p;
      await Future.delayed(const Duration(milliseconds: 1800));
    }
  }

  void _increase() {
    final delta = Random().nextDouble();
    double newValue = _progress + delta;
    newValue = newValue.clamp(0, 1);
    setState(() {
      _progress = newValue;
    });
  }

  void _decrease() {
    final delta = Random().nextDouble();
    double newValue = _progress - delta;
    newValue = newValue.clamp(0, 1);
    setState(() {
      _progress = newValue;
    });
  }
}
