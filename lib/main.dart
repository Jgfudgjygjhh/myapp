import 'package:flutter/material.dart';
import 'gemini_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  List<String> _questions = [];
  final String apiKey = "AIzaSyBIDzk4b4FgjXfkUeUhE029-YmI3PBtOFs";


  Future<void> _generateQuestions() async {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final questions = await generateQuestions(text, apiKey);
      setState(() {
        _questions = questions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateQuestions,
              child: const Text('Generate Questions'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _questions.isEmpty
                  ? const Center(child: Text('No questions yet.'))
                  : ListView.builder(
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_questions[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
