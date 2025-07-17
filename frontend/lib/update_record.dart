import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateRecord extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  UpdateRecord({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> updateRecord() async {
    try {
      String uri = "http://192.168.0.34/practice_api/update_data.php";
      var res = await http.post(
        Uri.parse(uri),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'name': name.text,
          'email': email.text,
          'password': password.text,
        },
      );
      var response = jsonDecode(res.body);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response['message'])));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response['message'])));
      }
    } catch (e) {
      print('Error updating record: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
    password.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Record'), centerTitle: true),
      body: Column(
        spacing: 10,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your Email',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your Password',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: updateRecord,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
