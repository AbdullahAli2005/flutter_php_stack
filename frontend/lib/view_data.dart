import 'dart:convert';

import 'package:crud_mysql/update_record.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];

  Future<void> deleteRecord(String uid) async {
    try {
      String uri = "http://192.168.0.34/practice_api/delete_data.php";
      var res = await http.post(
        Uri.parse(uri),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {'uid': uid},
        // encoding: Encoding.getByName("utf-8"),
      );
      var response = jsonDecode(res.body);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response['message'])));
        getRecord(); // Refresh the data after deletion
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response['message'])));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecord() async {
    String uri = "http://192.168.0.34/practice_api/view_data.php";

    try {
      var res = await http.get(
        Uri.parse(uri),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      setState(() {
        userData = jsonDecode(res.body);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void initState() {
    getRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Data')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateRecord(
                          name: userData[index]['uname'],
                          email: userData[index]['uemail'],
                          password: userData[index]['upassword'],
                        );
                      },
                    ),
                  );
                },
                title: Text(userData[index]['uname']),
                subtitle: Text(userData[index]['uemail']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    bool? confirmed = await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                          'Are you sure you want to delete this record?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      deleteRecord(userData[index]['uid']);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
