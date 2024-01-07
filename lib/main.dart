import 'package:assignment_app/newlostitem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LostFound());
}

class Found {
  final String name;
  final String item;
  final String detail;
  final String email;

  Found({
    required this.name,
    required this.item,
    required this.detail,
    required this.email,
  });
}

class LostFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost And Found App',
      home: LostFoundList(),
    );
  }
}

class LostFoundList extends StatefulWidget {
  @override
  _LostFoundListState createState() => _LostFoundListState();
}

class _LostFoundListState extends State<LostFoundList> {
  final List<Found> lost = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost And Found App'),
      ),
      body: ListView.builder(
        itemCount: lost.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lost[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item: ${lost[index].item}'),
                Text('Detail: ${lost[index].detail}'),
                Text('Email: ${lost[index].email}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailsScreen(
                    item: lost[index],
                    onDelete: () {
                      setState(() {
                        lost.removeAt(index);
                      });
                    },
                    onUpdate: (updatedItem) {
                      setState(() {
                        lost[index] = updatedItem;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToRegisterScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToRegisterScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );

    if (result != null && result is Found) {
      setState(() {
        lost.add(result);
      });
    }
  }
}

class ItemDetailsScreen extends StatelessWidget {
  final Found item;
  final Function onDelete;
  final Function onUpdate;

  ItemDetailsScreen({
    required this.item,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${item.name}'),
            Text('Item: ${item.item}'),
            Text('Detail: ${item.detail}'),
            Text('Email: ${item.email}'),
            ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToEditScreen(context);
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(); 
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemScreen(item: item)),
    );

    if (result != null && result is Found) {
      onUpdate(result); 
    }
  }
}

class EditItemScreen extends StatelessWidget {
  final Found item;

  EditItemScreen({required this.item});

  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController itemController =
      TextEditingController();
  final TextEditingController detailController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = item.name;
    itemController.text = item.item;
    detailController.text = item.detail;
    emailController.text = item.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
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

                if (name.isNotEmpty && item.isNotEmpty && detail.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Found(
                      name: name,
                      item: item,
                      detail: detail,
                      email: email,
                    ),
                  );
                } else {
                  
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

