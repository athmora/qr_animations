import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SalesData {
  const SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

const List<SalesData> _kData = [
  SalesData('Jan', 35),
  SalesData('Feb', 28),
  SalesData('Mar', 34),
  SalesData('Apr', 32),
  SalesData('May', 40)
];

class SyncfusionFlutterChartsPage extends StatelessWidget {
  const SyncfusionFlutterChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      package: "syncfusion_flutter_charts",
      widgets: [
        CartesianChart(),
        Chart2(),
        PyramidChart(),
        FunnelChart(),
      ],
    );
  }
}

class CartesianChart extends StatelessWidget {
  const CartesianChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      // Chart title
      title: ChartTitle(text: 'Propiedades vendidas'),
      // Enable legend
      legend: Legend(isVisible: true),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
            dataSource: _kData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: 'Ventas',
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ],
    );
  }
}

class Chart2 extends StatelessWidget {
  const Chart2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //Initialize the spark charts widget
      child: SfSparkLineChart.custom(
        //Enable the trackball
        trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
        //Enable marker
        marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
        //Enable data label
        labelDisplayMode: SparkChartLabelDisplayMode.all,
        xValueMapper: (int index) => _kData[index].year,
        yValueMapper: (int index) => _kData[index].sales,
        dataCount: 5,
      ),
    );
  }
}

class PyramidChart extends StatelessWidget {
  const PyramidChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfPyramidChart(
      title: ChartTitle(text: 'Piramide'),
      // Enable legend
      legend: Legend(isVisible: true),

      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: PyramidSeries<SalesData, String>(
        dataSource: _kData,
        xValueMapper: (SalesData sales, _) => sales.year,
        yValueMapper: (SalesData sales, _) => sales.sales,
        name: 'Ventas',
        // Enable data label
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    );
  }
}

class FunnelChart extends StatelessWidget {
  const FunnelChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfFunnelChart(
          title: ChartTitle(text: 'Funnel - Embudo'),
          // Enable legend
          legend: Legend(isVisible: true),

          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: FunnelSeries<SalesData, String>(
            dataSource: _kData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: 'Ventas',
            gapRatio: 0.1,
            neckWidth: "15%",
            neckHeight: "0%",
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ),
        
      ],
    );
  }
}
