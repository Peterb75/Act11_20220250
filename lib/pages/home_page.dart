import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapi/models/popular.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movieapi/services/router_service.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Popular> _futurePopular;

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
      return Popular.fromJson(jsonData);
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
              final popularData = snapshot.data!;
              return ListView.builder(
                itemCount: popularData.results.length,
                itemBuilder: (context, index) {
                  final result = popularData.results[index];
                  return ListTile(
                    title: Text(result.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(result.overview),
                        Text('Popularity: ${result.popularity}'),
                      ],
                    ),
                    onTap: () {
                      AutoRouter.of(context).push(DetailRoute(movie: result));                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${result.poster_path}'), // Agrega la URL de la imagen
                    ),
                    trailing: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Acción a realizar cuando se presiona el icono
            print('Se presionó el botón de búsqueda');
          },
        ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }}