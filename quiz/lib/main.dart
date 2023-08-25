import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> questions = [
    'Mario es el personaje principal de la franquicia de videojuegos "The Legend of Zelda".',
    'El juego "Fortnite" fue desarrollado por Epic Games.',
    'Minecraft es un juego de construcción y exploración en un mundo de bloques.',
    'El juego "Counter-Strike: Global Offensive" es un juego de rol en línea masivo.',
    '"The Elder Scrolls V: Skyrim" es un juego de aventuras y mundo abierto.',
    'El personaje principal de la serie de juegos "Metal Gear Solid" se llama Solid.',
    'El juego "Overwatch" fue desarrollado por Blizzard Entertainment.',
    '"The Witcher 3: Wild Hunt" es un juego de estrategia en tiempo real.',
    'La saga de juegos "Final Fantasy" fue creada por Square Enix.',
    'Call of Duty es una serie de videojuegos de deportes extremos.',
    'El personaje de videojuegos "Link" es conocido por ser el héroe enmascarado de Majoras Mask.',
    'El juego "Grand Theft Auto V" se desarrolla en una ciudad ficticia llamada San Andreas.',
  ];

  List<bool> answers = [
    false,
    true,
    true,
    false,
    true,
    true,
    true,
    false,
    true,
    false,
    false,
    true,
  ];

  int currentQuestionIndex = 0;
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    if (userAnswer == answers[currentQuestionIndex]) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }

    if (currentQuestionIndex == 11) {
      showResultDialog();
    } else {
      setState(() {
        currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      });
    }
  }

  void showResultDialog() {
    int correctAnswers = scoreKeeper.where((icon) => icon.color == Colors.green).length;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Terminado'),
          content: Text('Has respondido $correctAnswers de 12 preguntas correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
              child: Text('Reiniciar'),
            ),
          ],
        );
      },
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      scoreKeeper.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[currentQuestionIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.green;
                  },
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'Verdadero',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.red;
                  },
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

