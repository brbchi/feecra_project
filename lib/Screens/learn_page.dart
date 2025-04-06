import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      _Topic(
        title: 'Les capteurs',
        description:
        'Les capteurs de sol mesurent l’humidité pour savoir quand arroser.',
        imageUrl:
        'https://cepmaroc.com/111-large_default/capteur-d-humidite-de-sol-soil-yl-69.jpg',
      ),
      _Topic(
        title: 'Les pompes',
        description:
        'Les pompes envoient l’eau du réservoir vers les tuyaux.',
        imageUrl:
        'https://images.unsplash.com/photo-1526045478516-99145907023c?auto=format&fit=crop&w=400&q=60',
      ),
      _Topic(
        title: 'Les vannes',
        description:
        'Les vannes s’ouvrent ou se ferment automatiquement pour contrôler l’eau.',
        imageUrl:
        'https://cdn.manomano.com/media/edison/b/a/8/9/ba89257b79dc.jpg',
      ),
      _Topic(
        title: 'Cycle de l’eau',
        description:
        'Découvre comment l’eau circule dans la ferme et revient aux plantes.',
        imageUrl:
        'https://escape-kit.com/wp-content/uploads/2022/02/cycle-de-l-eau-min-1030x785.png',
      ),
      _Topic(
        title: 'Bonnes pratiques',
        description:
        'Arroser tôt le matin, pailler le sol et vérifier les capteurs régulièrement.',
        imageUrl:
        'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=400&q=60',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Apprends les bases de l’irrigation',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final t = topics[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          t.imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: progress.expectedTotalBytes != null
                                    ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.title,
                              style:
                              Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(
                            t.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Topic {
  final String title;
  final String description;
  final String imageUrl;

  _Topic({required this.title, required this.description, required this.imageUrl});
}