import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quiz/provider/music_provider.dart';
import 'package:quiz/provider/search_provider.dart';
import 'package:quiz/widgets/empty_container.dart';
import 'package:quiz/widgets/sound/sound_sample.dart';
import 'package:quiz/widgets/sound_search_widget.dart';

import 'models/music_model.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<Music> musics = [];
    bool add =false;
    Future<Music> getSound(String search) async {
      Music music;
      String url = 'http://api.deezer.com/search?q=$search';
      var response = await http.get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      add = true;
      music = Music.fromJson(data['data'][0]);
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
        return valuex.isListEmpty
            ? const EmptySoundList()
            : ChangeNotifierProvider(
              create: (BuildContext context) { return MusicProvider(); },
              child: FutureBuilder(
                  future: getSound(valuex.search),
                  builder: (BuildContext context, AsyncSnapshot<Music> snapshot) {
                    if (snapshot.hasData) {
                      if(add){
                        musics.add(snapshot.data!);
                        add = false;
                      }
                      return Consumer<MusicProvider>(
                          builder: (context, value, _) {
                        value.musics = musics;
                        return ListView.builder(
                            itemCount: value.musics.length,
                            itemBuilder: (BuildContext context, int position) {
                              return SoundSample(position: position, musics: value.musics);
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
