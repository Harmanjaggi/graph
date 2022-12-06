import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

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
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCartesianChart(
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        title: ChartTitle(text: 'Average temperature variation of London, UK'),
        series: <RangeColumnSeries>[
          RangeColumnSeries<ChartSampleData, DateTime>(
              dataSource: _chartData,
              xValueMapper: (ChartSampleData data, _) => data.x,
              highValueMapper: (ChartSampleData data, _) => data.high,
              lowValueMapper: (ChartSampleData data, _) => data.low,
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ],
        primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: DateFormat.MMM(),
            intervalType: DateTimeIntervalType.months,
            majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
      ),
    ));
  }

  List<ChartSampleData> getChartData() {
    return <ChartSampleData>[
      ChartSampleData(DateTime(2021, 1, 1), 3, 9),
      ChartSampleData(DateTime(2021, 2, 1), 4, 11),
      ChartSampleData(DateTime(2021, 3, 1), 6, 13),
      ChartSampleData(DateTime(2021, 4, 1), 9, 17),
      ChartSampleData(DateTime(2021, 5, 1), 12, 20),
      ChartSampleData(DateTime(2021, 6, 1), 12, 20)
    ];
  }
}

class ChartSampleData {
  ChartSampleData(this.x, this.high, this.low);
  final DateTime x;
  final double high;
  final double low;
}