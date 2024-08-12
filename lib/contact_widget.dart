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
        return DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text("My Cotact"),
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.credit_card_rounded,
                  ),
                )
              ]),
            ),
            body: TabBarView(
              children: [
                ContactListView1(),
                ContactListView2(),
              ],
            ),
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
          ),
        );
      },
    );
  }
}

class ContactListView1 extends StatelessWidget {
  const ContactListView1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
      return ListView.builder(
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
                    final provider =
                        Provider.of<ContactProvider>(context, listen: false);
                    provider.setCurrentContact(provider.items[index]);
                    return EditContactWidget();
                  },
                ));
              },
            );
          },
          itemCount: contactProvider.items.length);
    });
  }
}

class ContactListView2 extends StatelessWidget {
  const ContactListView2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemCount: contactProvider.items.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 252, 251, 237),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // Changed from Row to Column for better alignment in GridView
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Leading: Circle Avatar with the first letter of the name
                        CircleAvatar(
                          child: Text(contactProvider.items[index].name[0]),
                        ),
                        SizedBox(
                            width: 16.0), // Spacing between avatar and text

                        // Title and Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contactProvider.items[index].name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      4.0), // Spacing between name and details
                              Text(contactProvider.items[index].phone),
                              Text(contactProvider.items[index].email),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Trailing: Delete Icon Button
                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
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
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<ContactProvider>(context,
                                              listen: false)
                                          .deleteContact(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
