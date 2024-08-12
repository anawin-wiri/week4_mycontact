import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_widget.dart';
import 'package:my_contact/contact.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:my_contact/edit_contact_widget%20copy.dart';
import 'package:provider/provider.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Cotact"),
          ),
          body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(contactProvider.items[index].name[0]),
                  ),
                  title: Text(contactProvider.items[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contactProvider.items[index].phone),
                      Text(contactProvider.items[index].email)
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
                                      Provider.of<ContactProvider>(context,
                                              listen: false)
                                          .deleteContact(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete')),
                              ],
                            );
                          });
                    },
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        final provider = Provider.of<ContactProvider>(context,
                            listen: false);
                        provider.setCurrentContact(provider.items[index]);
                        return EditContactWidget();
                      },
                    ));
                  },
                );
              },
              itemCount: contactProvider.items.length),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AddContactWidget();
                },
              ));
            },
          ),
        );
      },
    );
  }
}
