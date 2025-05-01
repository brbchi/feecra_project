import 'package:flutter/material.dart';
import 'learn_page.dart';
import 'quiz_page.dart';
import 'game_page.dart';

class KidsHub extends StatelessWidget {
  const KidsHub({super.key});

  @override
  Widget build(BuildContext context) {
    // Définition des couleurs qui correspondent au style de QuizPage
    const Color primaryGreen = Color(0xFF4CAF50); // More appealing green
    const Color darkGreen = Color(0xFF2E7D32);
    const Color backgroundColor = Colors.white; // White background

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            '🌾 Farm IT – Kids Zone 🌱',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: primaryGreen,
          centerTitle: true,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: const Color(0xFF388E3C), // Softer dark green
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(
                icon: Icon(Icons.menu_book),
                text: 'Apprendre',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
              Tab(
                icon: Icon(Icons.quiz),
                text: 'Quiz',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
              Tab(
                icon: Icon(Icons.videogame_asset),
                text: 'Jeu',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Background decoration
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/farm_pattern.png',
                  repeat: ImageRepeat.repeat,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: backgroundColor,
                  ),
                ),
              ),
            ),

            // Tab content
            const TabBarView(
              children: [
                LearnPage(),
                QuizPage(),
                GamePage(),
              ],
            ),

            // Bottom decoration
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/grass_bottom.png',
                height: 60,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: primaryGreen,
          height: 10,
          width: double.infinity,
        ),
      ),
    );
  }
}