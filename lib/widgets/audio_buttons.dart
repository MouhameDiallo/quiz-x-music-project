import 'package:flutter/material.dart';

class AudioButtonBar extends StatelessWidget {
  const AudioButtonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Card(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(child: const Icon(Icons.play_arrow), onPressed: () {}),
            TextButton(child: const Icon(Icons.pause), onPressed: () {}),
            TextButton(child: const Icon(Icons.stop), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
