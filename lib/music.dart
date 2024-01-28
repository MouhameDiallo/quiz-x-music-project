import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quiz/provider/music_provider.dart';

import 'models/music_model.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  Future<List<Music>> getArtiste(String search) async {
    List<Music> musicList = [];
    String url = 'http://api.deezer.com/search?q=almulk';
    var response = await http.get(Uri.parse(url));

    Map data = jsonDecode(response.body);
    for (var music in data['data']) {
      musicList.add(Music.fromJson(music));
    }

    return musicList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Audio Coran',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: "serif"
          ),
        ),
        centerTitle: true,

        backgroundColor: Colors.blueGrey,
      ),
      body: ChangeNotifierProvider(
        create: (context) => MusicProvider(),
        child: FutureBuilder(
          future: getArtiste('Hello'),
          builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
            if (snapshot.hasData) {
              //return Text(snapshot.data![0].title!);
              print("Hello");
              return Consumer<MusicProvider>(builder: (context, value, _) {
                  value.musics = snapshot.data!;
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int position) {
                      print('x');
                            return GestureDetector(
                              onTap: () async {
                                final itemProvider = Provider.of<MusicProvider>(context,listen: false);
                                itemProvider.playPause(position);
                                },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(snapshot.data![position].artistPicture!),
                                ),
                                title: Text(snapshot.data![position].title!),
                                subtitle: Text(snapshot.data![position].artistName!),
                                trailing: value.musics[position].isPaused! ?const Icon(Icons.play_arrow):const Icon(Icons.pause),
                              ),
                            );
                          }

                      );
                }
              );
            } else {
              return const SpinKitChasingDots(
                color: Colors.grey,
                size: 30.0,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.search),
      ),
    );
  }
}
