import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Details.dart';
import 'config.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movies;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
        title: Text(
          'Movie Catalog',
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Icon(
            Icons.menu,
            color: mainColor,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieTitle(mainColor),
            Expanded(
              child: ListView.builder(
                itemCount: movies == null ? 0 : movies.length,
                itemBuilder: (context, i) {
                  return TextButton(
                    child: MovieCell(movies, i),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      primary: Colors.green[200],
                    ),
                    //padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetail(movies[i]);
                          },
                        ),
                      );
                    },
                    //color: Colors.white,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var apiKey = getApiKey();
  var url =
      Uri.parse('http://api.themoviedb.org/3/discover/movie?api_key=$apiKey');
  var response = await http.get(url);
  return json.decode(response.body);
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Text(
        'Selection Now!!!',
        //textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40.0,
          color: mainColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arvo',
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.i);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                margin: const EdgeInsets.all(16.0),
//                                child:    Image.network(image_url+movies[i]['poster_path'],width: 100.0,height: 100.0),
                child: Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(image_url + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                children: [
                  Text(
                    movies[i]['title'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    movies[i]['overview'],
                    maxLines: 3,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )),
          ],
        ),
        Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}
