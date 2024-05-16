import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:animate_do/animate_do.dart';

class AnimateDoPage extends StatelessWidget {
  const AnimateDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "animate_do",
      widgets: [
        FadeInLeft(child: const Square()),
        const SizedBox(height: 64),
        FadeInUp(child: const Square()),
        const SizedBox(height: 64),
        FadeInRight(child: const Square()),
        const SizedBox(height: 64),
        FadeInDown(child: const Square()),
      ],
    );
  }
}

class Square extends StatelessWidget {
  const Square({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.lightBlue,
    );
  }
}
