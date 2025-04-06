import 'package:flutter/material.dart';
import 'question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> _questions = [
    Question(
      text: 'Pourquoi arrose‑t‑on les plantes ?',
      options: [
        'Pour les décorer',
        'Pour leur donner de l’eau',
        'Pour les réchauffer',
      ],
      answerIndex: 1,
    ),
    Question(
      text: 'Quel capteur mesure l’humidité du sol ?',
      options: [
        'Capteur de température',
        'Capteur d’humidité',
        'Capteur de lumière',
      ],
      answerIndex: 1,
    ),
    Question(
      text: 'Quand vaut‑il mieux arroser ?',
      options: [
        'À midi',
        'Le soir tard',
        'Tôt le matin',
      ],
      answerIndex: 2,
    ),
  ];

  int _current = 0;
  int _score = 0;
  bool _answered = false;

  void _select(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      if (index == _questions[_current].answerIndex) _score++;
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _answered = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Résultat'),
        content: Text('Tu as obtenu $_score / ${_questions.length} bonnes réponses !'),
        actions: [
          TextButton(
            child: const Text('Rejouer'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _current = 0;
                _score = 0;
                _answered = false;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Question ${_current + 1}/${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(q.text, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          ...List.generate(q.options.length, (i) {
            final isCorrect = i == q.answerIndex;
            final isSelected = _answered && i == q.answerIndex;
            return Card(
              color: _answered
                  ? (i == q.answerIndex ? Colors.green.shade100 : Colors.red.shade100)
                  : null,
              child: ListTile(
                title: Text(q.options[i]),
                onTap: () => _select(i),
              ),
            );
          }),
          const Spacer(),
          ElevatedButton(
            onPressed: _answered ? _next : null,
            child: Text(_current == _questions.length - 1 ? 'Voir le score' : 'Suivant'),
          ),
        ],
      ),
    );
  }
}