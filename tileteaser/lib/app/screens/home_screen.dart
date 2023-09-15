import 'dart:async';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:tileteaser/app/utils/AppTheme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  List<int> indicesList = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int totalMoves = 0;
  int timePassed = 0;
  int gridSize = 3;
  int totalSize = 9;
  int blankIndex = 0;
  bool isStarted = false;
  late Timer time;

  void startTimer() {
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isStarted) {
        setState(() {
          timePassed++;
        });
      }
    });
  }

  bool isGameWin() {
    for (int i = 0; i < totalSize - 1; i++) {
      if (indicesList[i] != i + 1) {
        return false;
      }
    }
    return true;
  }

  void startGame() {
    setState(() {
      indicesList.shuffle();
      totalMoves = 0;
      timePassed = 0;
      blankIndex = indicesList.indexOf(0);
      isStarted = false;
    });
  }

  void showWinningPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),

            title: const Center(child: Text("You Won!!")),
            content: Text(
              "You won the game by $totalMoves moves in $timePassed seconds",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    startGame();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.mainColor,
                    ),
                    padding: const EdgeInsets.all(14),
                    child: const Text(
                      "Start Again",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    indicesList.shuffle();
    totalSize = gridSize * gridSize;
    blankIndex = indicesList.indexOf(0);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Tile Teaser",
              style: TextStyle(
                color: AppTheme.mainColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Moves: ",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  totalMoves.toString(),
                  style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              width: 300,
              height: 300,
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: gridSize * gridSize,
                  itemBuilder: (BuildContext context, index) {
                    return indicesList[index] != 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isStarted = true;
                                if ((index + 1) % gridSize ==
                                        (blankIndex + 1) % gridSize &&
                                    (index - blankIndex).abs() == 3) {
                                  indicesList[blankIndex] = indicesList[index];
                                  indicesList[index] = 0;
                                  blankIndex = index;
                                  totalMoves++;
                                  FlameAudio.play("swap.mp3");
                                } else if (index ~/ gridSize ==
                                        blankIndex ~/ gridSize &&
                                    (index - blankIndex).abs() == 1) {
                                  indicesList[blankIndex] = indicesList[index];
                                  indicesList[index] = 0;
                                  blankIndex = index;
                                  totalMoves++;
                                  FlameAudio.play("swap.mp3");
                                }
                              });
                              if (isGameWin()) {
                                showWinningPopUp(context);
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.mainColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  indicesList[index].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : const SizedBox.shrink();
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Time: ",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  timePassed.toString(),
                  style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                startGame();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
