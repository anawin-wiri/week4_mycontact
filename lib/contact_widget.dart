import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_widget.dart';
import 'package:my_contact/contact.dart';
import 'package:my_contact/edit_contact_widget%20copy.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  List<Contact> contacts = [
    Contact(
        id: 1,
        name: 'Contact1',
        phone: '0888888881',
        email: 'contact1@gmail.com'),
    Contact(
        id: 2,
        name: 'Contact2',
        phone: '0888888882',
        email: 'contact2@gmail.com'),
    Contact(
        id: 3,
        name: 'Contact3',
        phone: '0888888883',
        email: 'contact3@gmail.com'),
    Contact(
        id: 4,
        name: 'Contact4',
        phone: '0888888884',
        email: 'contact4@gmail.com'),
    Contact(
        id: 5,
        name: 'Contact5',
        phone: '0888888885',
        email: 'contact5@gmail.com'),
  ];
  int lastId = 6;
  void addContact(Contact contact) {
    setState(() {
      contact.id = lastId;
      contacts.add(contact);
    });
  }

  void editContact(int index, Contact contact) {
    setState(() {
      contacts[index] = contact;
    });
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cotact"),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(contacts[index].name[0]),
              ),
              title: Text(contacts[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contacts[index].phone),
                  Text(contacts[index].email)
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Contact'),
                          content: Text(
                              'Are you sure you want to delete this contact?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  deleteContact(index);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete')),
                          ],
                        );
                      });
                },
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditContactWidget(
                        contact: contacts[index],
                        editContact: (contact) {
                          editContact(index, contact);
                        },
                      ),
                    ));
              },
            );
          },
          itemCount: contacts.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddContactWidget(
                addContact: addContact,
              );
            },
          ));
        },
      ),
    );
  }
}
