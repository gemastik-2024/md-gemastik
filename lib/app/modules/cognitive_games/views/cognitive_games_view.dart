import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cognitive_games_controller.dart';

class CognitiveGamesView extends GetView<CognitiveGamesController> {
  const CognitiveGamesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Main Test Screen',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        )),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: List.generate(14, (index) {
            int gameNumber = index + 1;
            bool isLocked = gameNumber != controller.unlockedGames.value;

            return ElevatedButton(
              onPressed: () => controller.playGame(gameNumber, context),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.deepPurple,
                elevation: 10,
                side: const BorderSide(color: Colors.black, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                backgroundColor: isLocked ? Colors.grey : Colors.deepPurple,
                minimumSize: const Size(100, 120),
              ),
              child: Text(
                "Game ${controller.gameNameList[gameNumber - 1]}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }),
        ),
      ),
    );
  }
}
