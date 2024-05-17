import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.package,
    required this.widgets,
    this.persistentFooterButtons,
    this.fab,
    this.bottomNavigationBar,
  });

  final String package;
  final List<Widget> widgets;
  final List<Widget>? persistentFooterButtons;
  final Widget? fab;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFD),
      appBar: AppBar(title: Text(package)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, i) => const SizedBox(height: 16),
        itemBuilder: (_, i) => widgets[i],
        itemCount: widgets.length,
      ),
      persistentFooterButtons: persistentFooterButtons,
      floatingActionButton: fab,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
