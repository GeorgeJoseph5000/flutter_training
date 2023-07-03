import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:math';
import './model/Photo.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

Future<http.Response> fetchAlbum() {
  Random random = Random();
  int randomNumber = random.nextInt(100);
  return http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$randomNumber'));
}

Future<Photo> fetchPhoto() async {
  Random random = Random();
  int randomNumber = random.nextInt(5000);
  http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos/$randomNumber'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Photo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _HomePageState extends State<HomePage> {
  late Future<Photo> p;
  
  @override
  void initState() {
    super.initState();
    p = fetchPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FutureBuilder<Photo>(
              future: p,
              builder: ((context, snapshot) {
                try {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF1A1A3F),
                      rightDotColor: const Color(0xFFEA3799),
                      size: 200,
                    );
                  }
                  if (snapshot.hasData) {
                    return Image.network(snapshot.data!.url);
                  }
                } catch (e) {
                  print(e.toString());
                }

                return LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF1A1A3F),
                      rightDotColor: const Color(0xFFEA3799),
                      size: 200,
                    );
                
              })),
              ElevatedButton(onPressed: (){
                setState(() {
                  p = fetchPhoto();
                });
              }, child: Text("New"))
        ],
      ),
    );
  }
}



class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}




class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl']
    );
  }
}
