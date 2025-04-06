import 'package:flutter/material.dart';
import 'kids_hub.dart';

class KidsScreen extends StatelessWidget {
  const KidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.child_friendly, size: 120, color: Colors.orange),
            const SizedBox(height: 24),
            Text(
              'Apprenons l’irrigation en jouant !',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Ici, les enfants trouveront des jeux et des vidéos\npour comprendre comment poussent les plantes\net pourquoi l’eau est si importante.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Commencer'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KidsHub()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}