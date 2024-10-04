import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'employee_form.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    _refreshEmployeeList();
  }

  void _refreshEmployeeList() async {
    final data = await DatabaseHelper.instance.queryAllEmployees();
    setState(() {
      _employees = data;
    });
  }

  void _deleteEmployee(int id) async {
    await DatabaseHelper.instance.deleteEmployee(id);
    _showMessage('Employee Deleted');
    _refreshEmployeeList();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee List')),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${_employees[index]['name']} (${_employees[index]['designation']})'),
              subtitle: Text('Salary: ${_employees[index]['salary']} | Joining Date: ${_employees[index]['joiningDate']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmployeeForm(employee: _employees[index]),
                      ));
                      _refreshEmployeeList();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteEmployee(_employees[index]['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeForm()));
          _refreshEmployeeList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
