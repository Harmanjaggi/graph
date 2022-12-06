import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChartSampleData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
        tooltipPosition: TooltipPosition.auto,
        enable: true,
        opacity: 0,
        builder: (data, point, series, pointIndex, seriesIndex) {
          // return Column(
          //   children: [
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 18, color: Colors.black12),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xff00ACFF),
                width: 0.5,
              ),
            ),
            child: Text('₹${data.low} - ₹${data.high}'),
          );
          // Container(
          //   height: 50,
          //   width: 1,
          //   color: const Color(0xff00ACFF),
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   alignment: Alignment.center,
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     shape: BoxShape.circle,
          //   ),
          //   child: Container(
          //     height: 12,
          //     width: 12,
          //     decoration: const BoxDecoration(
          //       color: Color(0xff00ACFF),
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // ),
          // ],
          // );
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          margin: const EdgeInsets.all(16),
          selectionType: SelectionType.point,
          tooltipBehavior: _tooltipBehavior,
          title: ChartTitle(text: "Here's the chart"),
          series: <RangeColumnSeries>[
            RangeColumnSeries<ChartSampleData, String>(
              color: const Color(0xff00ACFF),
              borderRadius: BorderRadius.circular(8),
              dataSource: _chartData,
              xValueMapper: (ChartSampleData data, _) => data.x,
              highValueMapper: (ChartSampleData data, _) => data.low / 100000,
              lowValueMapper: (ChartSampleData data, _) => data.high / 100000,
            ),
          ],
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: 'min years - max years'),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            axisLine: const AxisLine(width: 0)
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value} L',
            majorGridLines: const MajorGridLines(width: 0.5),
            majorTickLines: const MajorTickLines(width: 0),
            axisLine: const AxisLine(width: 0)
          ),
        ),
      ),
    );
  }

  List<ChartSampleData> getChartData() {
    return <ChartSampleData>[
      ChartSampleData('0-2', 500000, 1500000),
      ChartSampleData('2-5', 700000, 1700000),
      ChartSampleData('5-10', 1300000, 3500000),
      ChartSampleData('10-25', 3000000, 6000000),
    ];
  }
}

class ChartSampleData {
  ChartSampleData(this.x, this.low, this.high);
  final String x;
  final int low;
  final int high;
}
