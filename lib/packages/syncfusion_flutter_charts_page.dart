import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _SalesData {
  const _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class SyncfusionFlutterChartsPage extends StatelessWidget {
  const SyncfusionFlutterChartsPage({super.key});
  static const List<_SalesData> data = [_SalesData('Jan', 35), _SalesData('Feb', 28), _SalesData('Mar', 34), _SalesData('Apr', 32), _SalesData('May', 40)];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "syncfusion_flutter_charts",
      widgets: [
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          //Initialize the spark charts widget
          child: SfSparkLineChart.custom(
            //Enable the trackball
            trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
            //Enable marker
            marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
            //Enable data label
            labelDisplayMode: SparkChartLabelDisplayMode.all,
            xValueMapper: (int index) => data[index].year,
            yValueMapper: (int index) => data[index].sales,
            dataCount: 5,
          ),
        ),
      ],
    );
  }
}
