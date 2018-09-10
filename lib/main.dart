import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//Criando o corpo do JSON
class Post {
  final int userID;
  final int id;
  final String title;
  final String body;

  //Criando o  construtor
  Post({this.userID, this.id, this.title, this.body});

  //Criar a função que converte o JSON para um objeto
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userID: json['userID'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

//Função para dar o fetch nos serviços da API RESTful

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200)
    return Post.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load post');
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Basic',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('JSON Basic'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String title = snapshot.data.title;
                String body = snapshot.data.body;
                int userId = snapshot.data.userID;
                int id = snapshot.data.id;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text('Title: $title'),
                    new Text('Body: $body'),
                    new Text('UserId: $userId'),
                    new Text('ID: $id')
                  ],
                );
              } else if (snapshot.hasError) return Text(snapshot.error);

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
