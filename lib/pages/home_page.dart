import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapi/models/popular.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movieapi/models/results.dart';
import 'package:movieapi/services/router_service.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Popular> _futurePopular;
  late List<Results> _resultsList = []; // Cambiado a List<Results>

  @override
  void initState() {
    super.initState();
    _futurePopular = fetchPopular();
  }

  Future<Popular> fetchPopular() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=3f70b28699809c62d6996c7f3c779675&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final popularData = Popular.fromJson(jsonData);

      setState(() {
        _resultsList = List.from(popularData.results); // Crear una copia modificable
      });

      return popularData;
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Center(
        child: FutureBuilder<Popular>(
          future: _futurePopular,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final result = _resultsList.removeAt(oldIndex);
                    _resultsList.insert(newIndex, result);
                  });
                },
                children: <Widget>[
                  for (final result in _resultsList)
                    ListTile(
                      key: Key('${result.title}'),
                      title: Text(result.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Popularity: ${result.popularity}'),
                        ],
                      ),
                      onTap: () {
                        AutoRouter.of(context).push(DetailRoute(movie: result));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${result.poster_path}'),
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
