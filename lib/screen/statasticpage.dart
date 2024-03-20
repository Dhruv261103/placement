import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 400, // Adjust the height as needed
                child: EmployeeSalaryChart(),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 400, // Adjust the height as needed
                child: StudentPlacementChart(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeSalaryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<SalaryData, String>> seriesList = [
      charts.Series<SalaryData, String>(
        id: 'Minimum Salary',
        data: [
          SalaryData('2015', 1, 9, 3.25),
          SalaryData('2016', 0.9, 11.4, 2.60),
          SalaryData('2017', 0.6, 6.37, 2.62),
          SalaryData('2018', 1.44, 9, 2.86),
          SalaryData('2019', 0.96, 9, 3.08),
          SalaryData('2020', 2.40, 7, 3.87),
          SalaryData('2021', 1.20, 14.50, 4.17),
          SalaryData('2022', 1.44, 18, 4.76),
          SalaryData('2023', 1.8, 23, 5.9),
          SalaryData('2024', 3, 6.5, 4.9),
        ],
        domainFn: (SalaryData salary, _) => salary.year,
        measureFn: (SalaryData salary, _) => salary.minSalary,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (SalaryData salary, _) =>
            '${salary.year}: \$${salary.minSalary}',
      ),
      charts.Series<SalaryData, String>(
        id: 'Maximum Salary',
        data: [
          SalaryData('2015', 1, 9, 3.25),
          SalaryData('2016', 0.9, 11.4, 2.60),
          SalaryData('2017', 0.6, 6.37, 2.62),
          SalaryData('2018', 1.44, 9, 2.86),
          SalaryData('2019', 0.96, 9, 3.08),
          SalaryData('2020', 2.40, 7, 3.87),
          SalaryData('2021', 1.20, 14.50, 4.17),
          SalaryData('2022', 1.44, 18, 4.76),
          SalaryData('2023', 1.8, 23, 5.9),
          SalaryData('2024', 3, 6.5, 4.9),
        ],
        domainFn: (SalaryData salary, _) => salary.year,
        measureFn: (SalaryData salary, _) => salary.maxSalary,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        labelAccessorFn: (SalaryData salary, _) =>
            '${salary.year}: \$${salary.maxSalary}',
      ),
      charts.Series<SalaryData, String>(
        id: 'Average Salary',
        data: [
          SalaryData('2015', 1, 9, 3.25),
          SalaryData('2016', 0.9, 11.4, 2.60),
          SalaryData('2017', 0.6, 6.37, 2.62),
          SalaryData('2018', 1.44, 9, 2.86),
          SalaryData('2019', 0.96, 9, 3.08),
          SalaryData('2020', 2.40, 7, 3.87),
          SalaryData('2021', 1.20, 14.50, 4.17),
          SalaryData('2022', 1.44, 18, 4.76),
          SalaryData('2023', 1.8, 23, 5.9),
          SalaryData('2024', 3, 6.5, 4.9),
        ],
        domainFn: (SalaryData salary, _) => salary.year,
        measureFn: (SalaryData salary, _) => salary.avgSalary,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (SalaryData salary, _) =>
            '${salary.year}: \$${salary.avgSalary}',
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 254, 247, 188),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Students Salary (2015-2024)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0),
            Expanded(
              child: charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [
                  charts.SeriesLegend(
                    position: charts.BehaviorPosition.bottom,
                    horizontalFirst: false,
                    cellPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                  charts.ChartTitle('Year',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle('Salary in LPA',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                ],
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelRotation: 45,
                    labelAnchor: charts.TickLabelAnchor.centered,
                    labelJustification: charts.TickLabelJustification.inside,
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 24,
                  ),
                  viewport: charts.NumericExtents(0, 24),
                  renderSpec: charts.GridlineRendererSpec(
                    // labelAnchor: charts.TickLabelAnchor.middle,
                    labelStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.gray.shadeDefault.darker,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentPlacementChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<charts.Series<PlacementData, String>> seriesList = [
      charts.Series<PlacementData, String>(
        id: 'Placement Percentage',
        data: [
          PlacementData('2015', 76.04),
          PlacementData('2016', 76.25),
          PlacementData('2017', 100),
          PlacementData('2018', 100),
          PlacementData('2019', 100),
          PlacementData('2020', 100),
          PlacementData('2021', 100),
          PlacementData('2022', 100),
          PlacementData('2023', 100),
          PlacementData('2024', 91),
        ],
        domainFn: (PlacementData placement, _) => placement.year,
        measureFn: (PlacementData placement, _) => placement.percentage,
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        labelAccessorFn: (PlacementData placement, _) =>
            '${placement.year}: ${placement.percentage}%',
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 254, 247, 188),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Students Placement Percentage (2015-2024)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0),
            Expanded(
              child: charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [
                  charts.SeriesLegend(
                    position: charts.BehaviorPosition.bottom,
                    horizontalFirst: false,
                    cellPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                  charts.ChartTitle('Year',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle('Percentage %',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                ],
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelRotation: 55,
                    labelAnchor: charts.TickLabelAnchor.centered,
                    labelJustification: charts.TickLabelJustification.inside,
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 10,
                  ),
                  viewport: charts.NumericExtents(0, 100),
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.gray.shadeDefault.darker,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalaryData {
  final String year;
  final double minSalary;
  final double maxSalary;
  final double avgSalary;

  SalaryData(this.year, this.minSalary, this.maxSalary, this.avgSalary);
}

class PlacementData {
  final String year;
  final double percentage;

  PlacementData(this.year, this.percentage);
}
