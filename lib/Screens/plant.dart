import 'package:flutter/material.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key}) : super(key: key);

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  /// Store plants as maps with name, image, humidity, season, and esp32.
  final List<Map<String, dynamic>> _plants = [
    {
      'name': 'Tomato',
      'image': 'assets/images/Tomato.jpg',
      'humidity': 70.0,
      'season': 'Summer',
      'esp32': 'ESP32 #1',
    },
    {
      'name': 'Spearmint',
      'image': 'assets/images/spearmint.jpg',
      'humidity': 45.0,
      'season': 'Spring',
      'esp32': 'ESP32 #2',
    },
    {
      'name': 'Sweet Potato',
      'image': 'assets/images/sweet-potato.jpg',
      'humidity': 60.0,
      'season': 'Autumn',
      'esp32': 'ESP32 #1',
    },
  ];

  /// This method shows a dialog for adding a new plant with season, recommended plant, and ESP32.
  Future<void> _addNewPlant() async {
    final seasons = ['Spring', 'Summer', 'Autumn', 'Winter'];
    final recommendedPlants = ['Tomato', 'Cucumber', 'Pepper', 'Lettuce'];
    final espDevices = ['ESP32 #1', 'ESP32 #2', 'ESP32 #3'];

    // Temporary variables for the user’s choices
    String? _selectedSeason = seasons.first;
    String? _selectedPlant = recommendedPlants.first;
    String? _selectedEsp32 = espDevices.first;

    // Show a dialog that lets the user pick from dropdowns
    final bool? userConfirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Add a New Plant'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Season dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Season',
                      ),
                      value: _selectedSeason,
                      items: seasons.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) {
                        setStateDialog(() {
                          _selectedSeason = val;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    // Recommended Plant dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Recommended Plant',
                      ),
                      value: _selectedPlant,
                      items: recommendedPlants.map((plant) {
                        return DropdownMenuItem(
                          value: plant,
                          child: Text(plant),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setStateDialog(() {
                          _selectedPlant = val;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    // ESP32 dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select ESP32',
                      ),
                      value: _selectedEsp32,
                      items: espDevices.map((esp) {
                        return DropdownMenuItem(value: esp, child: Text(esp));
                      }).toList(),
                      onChanged: (val) {
                        setStateDialog(() {
                          _selectedEsp32 = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );

    // If user pressed Add (true) and we have valid selections, create the new plant
    if (userConfirmed == true &&
        _selectedSeason != null &&
        _selectedPlant != null &&
        _selectedEsp32 != null) {
      setState(() {
        _plants.add({
          'name': _selectedPlant,
          'image': 'assets/images/plant.png', // Replace with your placeholder
          'humidity': 50.0,
          'season': _selectedSeason,
          'esp32': _selectedEsp32,
        });
      });
    }
  }

  /// Builds each grid tile: image, name, humidity circle, season, esp32 info, and delete button.
  Widget _buildPlantTile(Map<String, dynamic> plant, int index) {
    return Stack(
      children: [
        // Main card with image & text
        Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The image area
                Expanded(
                  child: Center(
                    child: Image.asset(
                      plant['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Plant name
                Text(
                  plant['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Season
                Text(
                  'Season: ${plant['season']}',
                  style: const TextStyle(fontSize: 14),
                ),
                // ESP32
                Text(
                  'ESP32: ${plant['esp32']}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        // Delete icon in the top-right corner
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                _plants.removeAt(index);
              });
            },
          ),
        ),

        // A circular badge at the bottom-right with humidity
        Positioned(
          bottom: 15,
          right: 10,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Text(
                '${plant['humidity'].toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// A colorful gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade300,
              Colors.blue.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        /// Use SafeArea so we don't overlap system bars
        child: SafeArea(
          child: Column(
            children: [
              // ----------------------------
              // Header
              // ----------------------------
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.eco, size: 32, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'My Garden',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // ----------------------------
              // Grid of Plants
              // ----------------------------
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: _plants.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,       // 2 columns
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (ctx, index) {
                        final plant = _plants[index];
                        return _buildPlantTile(plant, index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ----------------------------
      // FAB to add a new plant
      // ----------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPlant,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
