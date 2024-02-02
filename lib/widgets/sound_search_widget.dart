import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/search_provider.dart';

class SearchSoundWidget extends StatelessWidget {
  const SearchSoundWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    TextEditingController soundController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText:
              "Titre, Réciteur, Sourate...",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            controller: soundController,
          ),
        ),

        const SizedBox(
          height: 15.0,
        ),
        //Button Submit
        Container(
          height: 50,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[600],
          ),
          child: ElevatedButton(
            onPressed: () {
              var provider = Provider.of<SearchProvider>(context,listen: false);
              provider.setSearch(soundController.text);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
            child: const Text("Search",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
