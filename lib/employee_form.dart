import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class EmployeeForm extends StatefulWidget {
  final Map<String, dynamic>? employee;

  EmployeeForm({this.employee});

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _joiningDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!['name'];
      _designationController.text = widget.employee!['designation'];
      _salaryController.text = widget.employee!['salary'].toString();
      _joiningDateController.text = widget.employee!['joiningDate'];
    }
  }

  void _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      final employeeData = {
        'name': _nameController.text,
        'designation': _designationController.text,
        'salary': double.parse(_salaryController.text),
        'joiningDate': _joiningDateController.text,
      };

      if (widget.employee == null) {
        await DatabaseHelper.instance.insertEmployee(employeeData);
        _showMessage('Employee Saved');
      } else {
        await DatabaseHelper.instance.updateEmployee(widget.employee!['id'], employeeData);
        _showMessage('Employee Updated');
      }

      Navigator.pop(context, true);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _joiningDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                controller: _designationController,
                decoration: InputDecoration(labelText: 'Designation'),
                validator: (value) => value!.isEmpty ? 'Enter a designation' : null,
              ),
              TextFormField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Salary'),
                validator: (value) => value!.isEmpty ? 'Enter a salary' : null,
              ),
              TextFormField(
                controller: _joiningDateController,
                decoration: InputDecoration(
                  labelText: 'Joining Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Select a joining date' : null,
                readOnly: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEmployee,
                child: Text(widget.employee == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
