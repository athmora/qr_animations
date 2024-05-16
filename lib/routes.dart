import 'package:qr_animations/home_page.dart';
import 'package:qr_animations/packages/animate_do_page.dart';
import 'package:qr_animations/packages/animated_floating_buttons_page.dart';
import 'package:qr_animations/packages/animated_toggle_switch_page.dart';
import 'package:qr_animations/packages/auto_animated_page.dart';
import 'package:qr_animations/packages/dashed_circular_progress_bar_page.dart';
import 'package:qr_animations/packages/syncfusion_flutter_charts_page.dart';
import 'package:qr_animations/packages/wave_linear_progress_indicator_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (_) => const HomePage(),
    "wave_linear_progress_indicator": (_) => const WaveLinearProgressIndicatorPage(),
    "dashed_circular_progress_bar": (_) => const DashedCircularProgressBarPage(),
    "syncfusion_flutter_charts": (_) => const SyncfusionFlutterChartsPage(),
    "animate_do": (_) => const AnimateDoPage(),
    "animated_toggle_switch": (_) => const AnimatedToggleSwitchPage(),
    "auto_animated": (_) => const AutoAnimatedPage(),
    "animated_floating_buttons": (_) => const AnimatedFloatingButtonsPage(),
  };
}
