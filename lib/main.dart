import 'package:flutter/material.dart';
import 'employee_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee CRUD App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EmployeeList(),
    );
  }
}
