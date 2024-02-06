import 'package:flutter/material.dart';

class EmptySoundList extends StatelessWidget {
  const EmptySoundList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Liste vide',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
      )),
    );
  }
}
