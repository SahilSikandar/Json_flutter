import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_practice/Model/details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Details> details_list = [];
  Future<List<Details>> getpostapi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        details_list.add(Details.fromJson(i));
      }
      return details_list;
    } else {
      return details_list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('json'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getpostapi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: details_list.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Image.network(
                                    details_list[index].image.toString()));
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ));
  }
}
