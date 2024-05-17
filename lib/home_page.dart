import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:qr_animations/section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Widget> packages = [
    Section(package: "wave_linear_progress_indicator"),
    Section(package: "dashed_circular_progress_bar"),
    Section(package: "syncfusion_flutter_charts"),
    Section(package: "animate_do"),
    Section(package: "animated_toggle_switch"),
    Section(package: "auto_animated"),
    Section(package: "animated_floating_buttons"),
    Section(package: "salomon_bottom_bar"),
    Section(package: "flutter_floating_bottom_bar"),
    Section(package: "floating_frosted_bottom_bar"),
  ];

  @override
  Widget build(BuildContext context) {
    return const BasePage(package: "Inicio", widgets: packages);
  }
}
