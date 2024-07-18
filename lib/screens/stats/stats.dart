import 'package:expense_repository/expense_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatScreen extends StatelessWidget {
  final List<Expense> expenses;
  const StatScreen({Key? key, required this.expenses}) : super(key: key);
  // const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Sample data (you can replace with your actual data)
    double income = 0.0; // Example income
    double texpense = 0.0; // Example expense

    for (var expense in expenses) {
      // totalAmount += expense.amount;
      if(expense.expencetype==1){
        income += expense.amount;
      }else{
        texpense += expense.amount;
      }
      
      
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyPieChart(income: income, expense: texpense),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.green,
                ),
                const SizedBox(width: 5),
                Text('Income', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text('Expense', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  final double income;
  final double expense;

  const MyPieChart({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: income,
            title: '\$${income.toStringAsFixed(2)}',
            color: Colors.green,
            radius: 50,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            value: expense,
            title: '\$${expense.toStringAsFixed(2)}',
            color: Colors.red,
            radius: 50,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        startDegreeOffset: 180,
        pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
      ),
    );
  }
}
