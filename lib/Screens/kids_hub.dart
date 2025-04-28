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
          title: Stack(
            children: <Widget>[
              // Stroke Text
              Text(
                'FarmIT - Kids Zone',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white38, // Stroke Color
                ),
              ),
              // Fill Text
              Text(
                'FarmIT - Kids Zone',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Fill Color
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E7D32), // Dark Green
                  Color(0xFF66BB6A), // Light Green
                ],
              ),
            ),
          ),
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