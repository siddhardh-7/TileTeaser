import 'package:flutter/material.dart';
import 'package:tileteaser/app/puzzle_layout.dart';
import 'package:tileteaser/app/start_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color mainColor = Color(0xFF6B71E3);
  int moves = 0;
  bool isStarted = false;
  List<int> indicesList = [1, 2, 3, 5, 6, 0, 7, 8, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Tile Teaser",
              style: TextStyle(
                color: mainColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Moves: ",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "${moves.toString()}",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              PuzzleLayout(mainColor: mainColor, indices: indicesList, blankIndex: indicesList.indexOf(0),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Time: ",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "${moves.toString()}",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              StartButton(mainColor: mainColor),
            ],
          ),
        ));
  }
}

