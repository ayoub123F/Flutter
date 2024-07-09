import 'package:flutter/material.dart';

import 'gallery-data-page.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword = "";
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(keyword),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(fontSize: 22),
              onChanged: (value) {
                setState(() {
                  this.keyword = value;
                });
              },
              controller: editingController,
              decoration: InputDecoration(hintText: 'Type a place'),
              onSubmitted: (value) {
                this.keyword = value;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryDataPage(this.keyword),
                  ),
                );
                editingController.text = "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.deepOrangeAccent,
                child: Text(
                  "Get Images",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryDataPage(keyword),
                    ),
                  );
                  editingController.text = "";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
