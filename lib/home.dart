import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Screens/plant.dart';
import 'Screens/vanes.dart';
import 'Screens/historyScreen.dart';
import 'Screens/capteurs.dart';
import 'Screens/reservoirScreen.dart';
import 'Screens/kidsScreen.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PlantScreen(),     // 0
    VanesScreen(),           // 1
    HistoricScreen(),        // 2
    capteurScreen(),         // 3
    ReservoirScreen(),       // 4
    const KidsScreen(),      // 5
  ];

  /* ────────────────────────── Déconnexion sûre ────────────────────────── */
  Future<void> _logout() async {
    // attendre la frame suivante pour éviter le lock du Navigator
    await Future.microtask(() async {
      await FirebaseAuth.instance.signOut();
      // Aucune navigation manuelle : StreamBuilder de main.dart s’occupe du reste
    });
  }

  void _confirmLogout() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Confirmer la déconnexion',
      desc: 'Êtes-vous certain·e de vouloir vous déconnecter ?',
      btnCancelText: 'Annuler',
      btnOkText: 'Oui',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        // 1) Ferme la boîte de dialogue (retire sa route)
        Navigator.of(context, rootNavigator: true).pop();

        // 2) Déconnexion Firebase
        await FirebaseAuth.instance.signOut();

        // 3) Remplacement TOTAL de la pile par LoginScreen
        if (!mounted) return;  // sécurité si le widget a été démonté
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,  // supprime toutes les routes précédentes
        );
      },
    ).show();
  }

  /* ────────────────────────────────────────────────────────────────────── */

  @override
  Widget build(BuildContext context) {
    // Si jamais on arrive ici sans user (théoriquement impossible)
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const LoginScreen();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Smart Irrigation'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Se déconnecter',
            onPressed: _confirmLogout,
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_florist), label: 'Plant'),
          BottomNavigationBarItem(
              icon: Icon(Icons.water_drop), label: 'Pompes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historique'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sensors), label: 'Capteurs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.straighten), label: 'Réservoir'),
          BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly), label: 'Kids'),
        ],
      ),
    );
  }
}
