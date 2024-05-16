import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class AnimatedFloatingButtonsPage extends StatelessWidget {
  const AnimatedFloatingButtonsPage({super.key});

  static final GlobalKey<AnimatedFloatingActionButtonState> animationKey = GlobalKey<AnimatedFloatingActionButtonState>();

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "animated_floating_buttons",
      widgets: const [],
      fab: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[float1(), float2()],
          key: key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }
}
