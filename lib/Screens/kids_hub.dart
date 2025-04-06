import 'package:flutter/material.dart';
import 'learn_page.dart';
import 'quiz_page.dart';
import 'game_page.dart';

class KidsHub extends StatelessWidget {
  const KidsHub({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farm IT – Kids Zone'),
          backgroundColor: Colors.green,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.menu_book), text: 'Apprendre'),
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
              Tab(icon: Icon(Icons.videogame_asset), text: 'Jeu'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LearnPage(),
            QuizPage(),
            GamePage(),
          ],
        ),
      ),
    );
  }
}