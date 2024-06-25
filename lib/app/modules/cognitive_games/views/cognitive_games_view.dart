import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cognitive_games_controller.dart';

class CognitiveGamesView extends GetView<CognitiveGamesController> {
  const CognitiveGamesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CognitiveGamesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CognitiveGamesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
