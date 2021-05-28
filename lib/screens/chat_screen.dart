import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(10),
          child: Text('text'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chat')
              .snapshots()
              .listen((event) {
            print(event);
          });
        },
      ),
    );
  }
}
