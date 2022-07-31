import 'package:chart_test/calculate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collatz Graph Plotter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final TextEditingController controller = TextEditingController();

    Column result = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text("Count : $count"),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Text("Y Points: "),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 10,
                        children: points
                            .map((point) => Text("${printYPoint(point)}"))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.white.withOpacity(.7),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * .8,
                child: AspectRatio(
                  aspectRatio: 1 / 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: LineChart(
                        LineChartData(
                          maxY: yMax + 2,
                          minY: 0,
                          maxX: count + 2,
                          minX: 0,
                          lineBarsData: [
                            LineChartBarData(
                                spots: points
                                    .map((point) => FlSpot(point.x, point.y))
                                    .toList(),
                                isCurved: isCurved,
                                dotData: FlDotData(show: showDot)),
                          ],
                        ),
                        swapAnimationDuration: Duration(milliseconds: 150),
                        swapAnimationCurve: Curves.linear,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text("Curve Vertices"),
                      Switch(
                          value: isCurved,
                          onChanged: (value) =>
                              setState(() => isCurved = !isCurved)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Show vertice dots"),
                      Switch(
                          value: showDot,
                          onChanged: (value) =>
                              setState(() => showDot = !showDot)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chart Test"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Enter a positive integer",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: (num) {
                    valueEntered = true;
                    number = double.parse(num.trim());
                    points = [];
                    yCoordinates = [];
                    count = 0;
                    yMax = 0;
                    generateYPoints(number);
                    generatePoints();
                  },
                ),
              ),
              if (valueEntered) result,
            ],
          ),
        ),
      ),
    );
  }
}
