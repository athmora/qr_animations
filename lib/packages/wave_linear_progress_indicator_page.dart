import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

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
