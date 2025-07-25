import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Track {
  final String name;
  final String artist;
  final String imageUrl;

  Track({required this.name, required this.artist, required this.imageUrl});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      artist: json['artists'][0]['name'],
      imageUrl: json['album']['images'][0]['url'],
    );
  }
}

Future<List<Track>> fetchTopTracks(String artistId, String accessToken) async {
  final response = await http.get(
    Uri.parse(
      'https://api.spotify.com/v1/artists/$artistId/top-tracks?market=US',
    ),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    List<dynamic> tracksJson = json.decode(response.body)['tracks'];
    return tracksJson.map((track) => Track.fromJson(track)).toList();
  } else {
    throw Exception('Failed to load tracks');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tracks - Alice In Chains',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TopTracksPage(),
    );
  }
}

class TopTracksPage extends StatefulWidget {
  @override
  _TopTracksPageState createState() => _TopTracksPageState();
}

class _TopTracksPageState extends State<TopTracksPage> {
  late Future<List<Track>> _topTracks;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTopTracks();
  }

  void _fetchTopTracks() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    fetchTopTracks('64tNsm6TnZe2zpcMVMOoHL', '')
        .then((tracks) {
          setState(() {
            _topTracks = Future.value(tracks);
            _isLoading = false;
          });
        })
        .catchError((error) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Erro ao carregar faixas: $error';
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Tracks - Alice In Chains')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : FutureBuilder<List<Track>>(
                future: _topTracks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhuma faixa encontrada.'));
                  } else {
                    final tracks = snapshot.data!;
                    return ListView.builder(
                      itemCount: tracks.length,
                      itemBuilder: (context, index) {
                        final track = tracks[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              track.imageUrl,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(track.name),
                            subtitle: Text(track.artist),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
    );
  }
}
