import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FarmPlot {
  int stage; // 0 = graine, 1 = pousse, 2 = prêt à récolter, 3 = fané
  int water; // niveau d'eau restant
  static const int maxWater = 5;
  int growthProgress = 0; // compte les ticks pour grandir

  FarmPlot() : stage = 0, water = maxWater;

  void tick() {
    if (stage == 3) return; // fané, en attente d'arrosage
    water--;
    if (water <= 0) {
      stage = 3; // fané
      water = 0;
    } else {
      growthProgress++;
      if (growthProgress >= 5 && stage < 2) {
        stage++;
        growthProgress = 0;
      }
    }
  }

  void waterPlant() {
    water = maxWater;
    if (stage == 3) {
      stage = 0;
      growthProgress = 0;
    }
  }

  bool get readyToHarvest => stage == 2;
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<FarmPlot> _plots = List.generate(4, (_) => FarmPlot());
  late Timer _timer;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        for (final p in _plots) {
          p.tick();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onPlotTap(int index) {
    setState(() {
      final plot = _plots[index];
      if (plot.readyToHarvest) {
        _score++;
        plot.stage = 0;
        plot.water = FarmPlot.maxWater;
        plot.growthProgress = 0;
      } else {
        plot.waterPlant();
      }
    });
  }

  Color _stageColor(int stage) {
    switch (stage) {
      case 0:
        return Colors.brown.shade300; // graine
      case 1:
        return Colors.green.shade400; // pousse
      case 2:
        return Colors.yellow.shade600; // prêt
      case 3:
      default:
        return Colors.grey; // fané
    }
  }

  IconData _stageIcon(int stage) {
    switch (stage) {
      case 0:
        return Icons.grass;
      case 1:
        return Icons.spa;
      case 2:
        return Icons.local_florist;
      case 3:
      default:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text('Récoltes : $_score', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _plots.length,
            itemBuilder: (context, index) {
              final plot = _plots[index];
              return GestureDetector(
                onTap: () => _onPlotTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: _stageColor(plot.stage),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(_stageIcon(plot.stage), size: 64, color: Colors.white),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: LinearProgressIndicator(
                          value: plot.water / FarmPlot.maxWater,
                          backgroundColor: Colors.white24,
                          color: Colors.blueAccent,
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}