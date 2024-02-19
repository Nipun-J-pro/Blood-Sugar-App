import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Sugar Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BloodSugarInputScreen(),
    );
  }
}

class BloodSugarInputScreen extends StatelessWidget {
  final _beforeGlucoseController = TextEditingController();
  final _afterGlucoseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _beforeGlucoseController,
              decoration: InputDecoration(labelText: 'Before Meal (mg/dL)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _afterGlucoseController,
              decoration: InputDecoration(labelText: 'After Meal (mg/dL)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final beforeGlucose =
                    double.tryParse(_beforeGlucoseController.text);
                final afterGlucose =
                    double.tryParse(_afterGlucoseController.text);

                if (beforeGlucose != null && afterGlucose != null) {
                  Get.to(
                    () => BloodSugarInfoScreen(
                      beforeGlucose: beforeGlucose,
                      afterGlucose: afterGlucose,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid values')),
                  );
                }
              },
              child: Text('Show Info'),
            ),
          ],
        ),
      ),
    );
  }
}

class BloodSugarInfoScreen extends StatelessWidget {
  final double beforeGlucose;
  final double afterGlucose;

  BloodSugarInfoScreen(
      {required this.beforeGlucose, required this.afterGlucose});

  @override
  Widget build(BuildContext context) {
    String info;

    if (beforeGlucose < 80 || afterGlucose > 180) {
      info = 'Low blood sugar level. Please consult a doctor.';
    } else if (beforeGlucose < 130 && afterGlucose < 180) {
      info = 'Normal blood sugar level. Keep up the good work.';
    } else {
      info = 'High blood sugar level. Please consult a doctor.';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Info'),
      ),
      body: Center(
        child: Text(info),
      ),
    );
  }
}
