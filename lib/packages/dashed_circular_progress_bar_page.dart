import 'dart:math';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';

class DashedCircularProgressBarPage extends StatefulWidget {
  const DashedCircularProgressBarPage({super.key});

  @override
  State<DashedCircularProgressBarPage> createState() => _DashedCircularProgressBarPageState();
}

class _DashedCircularProgressBarPageState extends State<DashedCircularProgressBarPage> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  final ValueNotifier<double> _valueNotifier2 = ValueNotifier(0);

  double progress1 = 76;
  double progress2 = 34;
  double progress3 = 87;
  double progress4 = 180;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "dashed_circular_progress_bar",
      widgets: [
        DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1, // width ÷ height
          valueNotifier: _valueNotifier,
          progress: progress1,
          maxProgress: 100,
          corners: StrokeCap.butt,
          foregroundColor: Colors.blue,
          backgroundColor: const Color(0xffeeeeee),
          foregroundStrokeWidth: 36,
          backgroundStrokeWidth: 36,
          animation: true,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (_, double value, __) => Text(
                '${value.toInt()}%',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 60),
              ),
            ),
          ),
        ),
        DashedCircularProgressBar.aspectRatio(
          aspectRatio: 2, // width ÷ height
          progress: progress2,
          startAngle: 270,
          sweepAngle: 180,
          circleCenterAlignment: Alignment.bottomCenter,
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xffeeeeee),
          foregroundStrokeWidth: 3,
          backgroundStrokeWidth: 2,
          backgroundGapSize: 2,
          backgroundDashSize: 1,
          seekColor: Colors.yellow,
          seekSize: 22,
          animation: true,
        ),
        DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1, // width ÷ height
          valueNotifier: _valueNotifier2,
          progress: progress3,
          startAngle: 225,
          sweepAngle: 100,
          foregroundColor: Colors.green,
          backgroundColor: const Color(0xffeeeeee),
          foregroundStrokeWidth: 15,
          backgroundStrokeWidth: 15,
          animation: true,
          seekSize: 6,
          seekColor: const Color(0xffeeeeee),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier2,
              builder: (_, double value, __) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${value.toInt()}%',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 60),
                  ),
                  const Text(
                    'Subtitulo',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        DashedCircularProgressBar.square(
          dimensions: 350,
          progress: progress4,
          maxProgress: 360,
          startAngle: -27.5,
          foregroundColor: Colors.redAccent,
          backgroundColor: const Color(0xffeeeeee),
          foregroundStrokeWidth: 7,
          backgroundStrokeWidth: 7,
          foregroundGapSize: 5,
          foregroundDashSize: 55,
          backgroundGapSize: 5,
          backgroundDashSize: 55,
          animation: true,
          child: const Icon(Icons.favorite, color: Colors.redAccent, size: 126),
        ),
      ],
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: _randomize,
          tooltip: 'randomize',
          child: const Icon(Icons.repeat),
        ),
      ],
    );
  }

  static const List<double> posibles = [0, 45, 90, 135, 180, 270, 360];

  void _randomize() {
    final random = Random().nextDouble() * 100;
    final random4 = Random().nextInt(7);
    setState(() {
      progress1 = random;
      progress2 = random;
      progress3 = random;
      progress4 = posibles[random4];
    });
  }
}
