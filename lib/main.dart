import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),
      ),
      home: const HomeScreen(),
    );
  }
}

// ---------------- QUESTIONS ----------------

class Question {
  final String question;
  final List<String> options;
  final int answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}

final List<Question> questions = [
  Question(
    question: "Which language is used to develop Flutter applications?",
    options: ["Java", "Dart", "Python", "C++"],
    answer: 1,
  ),
  Question(
    question: "Which company developed Flutter?",
    options: ["Microsoft", "Apple", "Google", "Amazon"],
    answer: 2,
  ),
  Question(
    question: "Which widget is used for a button in Flutter?",
    options: [
      "TextButton",
      "ButtonWidget",
      "ClickButton",
      "PressWidget"
    ],
    answer: 0,
  ),
  Question(
    question: "Which keyword is used to create a constant in Dart?",
    options: ["let", "constant", "const", "finalize"],
    answer: 2,
  ),
  Question(
    question: "Which widget provides the basic visual structure of a screen?",
    options: ["Container", "Scaffold", "Column", "Row"],
    answer: 1,
  ),
  Question(
    question: "What is used to arrange widgets vertically?",
    options: ["Row", "Column", "Stack", "ListView"],
    answer: 1,
  ),
  Question(
    question: "What is used to arrange widgets horizontally?",
    options: ["Row", "Column", "Stack", "Center"],
    answer: 0,
  ),
  Question(
    question: "Which file is the main entry point of a Flutter app?",
    options: [
      "index.html",
      "main.dart",
      "app.java",
      "flutter.dart"
    ],
    answer: 1,
  ),
  Question(
    question: "Which widget displays text in Flutter?",
    options: ["Text", "Label", "String", "TextView"],
    answer: 0,
  ),
  Question(
    question: "Which language is Flutter based on?",
    options: ["Dart", "Java", "Kotlin", "Swift"],
    answer: 0,
  ),
];

// ---------------- SCORE TRACKER ----------------

List<int> scoreHistory = [];

// ---------------- HOME SCREEN ----------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.quiz,
                size: 100,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                "Welcome to Quiz App",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Test your knowledge and track your score!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );

                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),

                  child: const Text(
                    "START QUIZ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: OutlinedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScoreHistoryScreen(),
                      ),
                    );

                  },

                  child: const Text(
                    "SCORE TRACKER",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- QUIZ SCREEN ----------------

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  int currentQuestion = 0;

  int score = 0;

  int? selectedAnswer;

  void selectAnswer(int index) {

    setState(() {
      selectedAnswer = index;
    });

  }

  void nextQuestion() {

    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an answer"),
        ),
      );

      return;
    }

    if (selectedAnswer == questions[currentQuestion].answer) {
      score++;
    }

    if (currentQuestion == questions.length - 1) {

      scoreHistory.add(score);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
          ),
        ),
      );

    } else {

      setState(() {

        currentQuestion++;

        selectedAnswer = null;

      });

    }
  }

  @override
  Widget build(BuildContext context) {

    Question question = questions[currentQuestion];

    double progress =
        (currentQuestion + 1) / questions.length;

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Quiz",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Question ${currentQuestion + 1} of ${questions.length}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 3,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: question.options.length,

                itemBuilder: (context, index) {

                  bool selected =
                      selectedAnswer == index;

                  return Card(

                    color: selected
                        ? Colors.deepPurple.shade100
                        : Colors.white,

                    child: RadioListTile<int>(

                      value: index,

                      groupValue: selectedAnswer,

                      onChanged: (value) {

                        selectAnswer(value!);

                      },

                      title: Text(
                        question.options[index],
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed: nextQuestion,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),

                child: Text(
                  currentQuestion == questions.length - 1
                      ? "SUBMIT"
                      : "NEXT",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- RESULT SCREEN ----------------

// ---------------- RESULT SCREEN ----------------

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        (score / questions.length) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Result",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              // Trophy
              const Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.amber,
              ),

              const SizedBox(height: 15),

              // Completed text
              const Text(
                "Quiz Completed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Score Card
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 25,
                  ),

                  child: Column(
                    children: [

                      const Text(
                        "Your Score",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "$score / ${questions.length}",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "${percentage.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Performance message
              Text(
                percentage >= 80
                    ? "Excellent! 🎉"
                    : percentage >= 50
                        ? "Good Job! 👍"
                        : "Keep Practicing! 💪",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Try Again Button
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            const QuizScreen(),
                      ),

                      (route) => false,
                    );

                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),

                  child: const Text(
                    "TRY AGAIN",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Score Tracker Button
              SizedBox(
                width: double.infinity,
                height: 50,

                child: OutlinedButton(
                  onPressed: () {

                    Navigator.pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            const ScoreHistoryScreen(),
                      ),

                      (route) => false,
                    );

                  },

                  child: const Text(
                    "VIEW SCORE TRACKER",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
// ---------------- SCORE HISTORY SCREEN ----------------

class ScoreHistoryScreen extends StatelessWidget {

  const ScoreHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    int highestScore = 0;

    double average = 0;

    if (scoreHistory.isNotEmpty) {

      highestScore =
          scoreHistory.reduce((a, b) => a > b ? a : b);

      int total =
          scoreHistory.reduce((a, b) => a + b);

      average =
          total / scoreHistory.length;
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Score Tracker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(

              children: [

                Expanded(
                  child: scoreCard(
                    "Highest",
                    "$highestScore/${questions.length}",
                    Icons.emoji_events,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: scoreCard(
                    "Average",
                    "${average.toStringAsFixed(1)}/${questions.length}",
                    Icons.analytics,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "Quiz Attempts",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(

              child: scoreHistory.isEmpty

                  ? const Center(
                      child: Text(
                        "No quiz attempts yet.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )

                  : ListView.builder(

                      itemCount: scoreHistory.length,

                      itemBuilder: (context, index) {

                        int score =
                            scoreHistory[index];

                        double percentage =
                            (score / questions.length) * 100;

                        return Card(

                          child: ListTile(

                            leading: CircleAvatar(
                              backgroundColor:
                                  Colors.deepPurple,
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            title: Text(
                              "Attempt ${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              "${percentage.toStringAsFixed(0)}%",
                            ),

                            trailing: Text(
                              "$score/${questions.length}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );

                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),

                child: const Text(
                  "HOME",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scoreCard(
    String title,
    String value,
    IconData icon,
  ) {

    return Card(

      elevation: 3,

      child: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            Icon(
              icon,
              size: 35,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}