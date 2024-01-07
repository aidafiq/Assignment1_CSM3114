import 'package:assignment_app/main.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found Lost Item:'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            TextFormField(
              controller: detailController,
              decoration: InputDecoration(labelText: 'Detail'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final item = itemController.text;
                final detail = detailController.text;
                final email = emailController.text;

                if (name.isNotEmpty &&
                    item.isNotEmpty &&
                    detail.isNotEmpty &&
                    email.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Found(name: name, item: item, detail: detail, email: email),
                  );
                } else {

                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
