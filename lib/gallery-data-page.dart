import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryDataPage extends StatefulWidget {
  String keyword;
  GalleryDataPage(this.keyword);

  @override
  State<GalleryDataPage> createState() => _GalleryDataPageState();
}

class _GalleryDataPageState extends State<GalleryDataPage> {
  int currentPage = 1;
  int size = 10;
  late int totalPages;
  ScrollController _scrollController = new ScrollController();
  List<dynamic> hits = [];
  var galleryData;
  @override
  void initState() {
    super.initState();
    this.getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          ++currentPage;
          this.getData();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  getData() {
    String url =
        "https://pixabay.com/api/?key=44782695-4dc382f9c461886bf0f8c9876&q=${widget.keyword}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then(
      (resp) {
        setState(() {
          galleryData = json.decode(resp.body);
          hits.addAll(galleryData['hits']);
          if (galleryData['totalHits'] % size == 0)
            totalPages = galleryData['totalHits'] ~/ size;
          else
            totalPages = (galleryData['totalHits'] / size).floor() + 1;
          print(hits);
        });
      },
    ).catchError(
      (err) {
        print(err);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.keyword}, page ${currentPage}/${totalPages}"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: (galleryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: (galleryData == null ? 0 : hits.length),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  hits[index]['tags'],
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Card(
                          child: Image.network(
                            hits[index]['webformatURL'],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
    );
  }
}
