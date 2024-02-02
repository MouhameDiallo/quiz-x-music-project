import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quiz/provider/music_provider.dart';
import 'package:quiz/provider/search_provider.dart';
import 'package:quiz/widgets/sound_search_widget.dart';

import 'models/music_model.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<Music> musics = [];
    Future<Music> getSound(String search) async {
      Music music;
      String url = 'http://api.deezer.com/search?q=$search';
      var response = await http.get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      music = Music.fromJson(data['data'][0]);
      print('Sound: ${music.title}');
      return music;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Audio Coran',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<SearchProvider>(builder: (context, valuex, _) {
        return valuex.search == ''
            ? Container()
            : ChangeNotifierProvider(
              create: (BuildContext context) { return MusicProvider(); },
              child: FutureBuilder(
                  future: getSound(valuex.search),
                  builder: (BuildContext context, AsyncSnapshot<Music> snapshot) {
                    if (snapshot.hasData) {
                      //return Text(snapshot.data![0].title!);
                      musics.add(snapshot.data!);
                      return Consumer<MusicProvider>(
                          builder: (context, value, _) {
                        value.musics = musics;
                        return ListView.builder(
                            itemCount: value.musics.length,
                            itemBuilder: (BuildContext context, int position) {
                              print('x -> ${value.musics.length}');
                              return GestureDetector(
                                onTap: () async {
                                  final itemProvider = Provider.of<MusicProvider>(
                                      context,
                                      listen: false);
                                  itemProvider.playPause(position);
                                },
                                onDoubleTap: () {
                                  Navigator.pushNamed(context, '/details', arguments: {
                                    'music': value.musics[position]
                                  });
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          value.musics[position].artistPicture!),
                                    ),
                                    title: Text(value.musics[position].title!),
                                    subtitle:
                                        Text(value.musics[position].artistName!),
                                    trailing: value.musics[position].isPaused!
                                        ? const Icon(Icons.play_arrow)
                                        : const Icon(Icons.pause),
                                  ),
                                ),
                              );
                            });
                      });
                    } else {
                      return const SpinKitChasingDots(
                        color: Colors.grey,
                        size: 30.0,
                      );
                    }
                  },
                ),
            );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SearchSoundWidget(),
              );
            },
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
