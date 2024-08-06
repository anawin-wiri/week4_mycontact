import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_contact/contact.dart';

class EditContactWidget extends StatefulWidget {
  final Function(Contact contact) editContact;
  final Contact contact;
  const EditContactWidget(
      {Key? key, required this.contact, required this.editContact})
      : super(key: key);

  @override
  _EditContactWidgetState createState() => _EditContactWidgetState();
}

class _EditContactWidgetState extends State<EditContactWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    phoneController = TextEditingController(text: widget.contact.phone);
    emailController = TextEditingController(text: widget.contact.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit New Contact'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Phone', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    widget.editContact(Contact(
                        id: widget.contact.id,
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Process Data')));
                  }
                },
                child: Text('Edit Contact')),
          ],
        ),
      ),
    );
  }
}
