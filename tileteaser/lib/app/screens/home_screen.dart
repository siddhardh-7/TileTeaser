import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tileteaser/app/start_button.dart';
import 'package:tileteaser/app/utils/AppTheme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> indicesList = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int totalMoves = 0;
  int timePassed = 0;
  int gridSize = 3;
  int totalSize = 9;
  int blankIndex = 0;
  bool isStarted = false;
  late Timer time ;

  void startTimer() {
    time = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isStarted) {
        setState(() {
          timePassed++;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    indicesList.shuffle();
    totalSize = gridSize*gridSize;
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
                Text(
                  "Moves: ",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  "${totalMoves.toString()}",
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
              padding: EdgeInsets.all(10),
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
                                if ((index+1)%gridSize == (blankIndex+1)%gridSize && (index - blankIndex).abs() == 3) {
                                  indicesList[blankIndex] =  indicesList[index];
                                  indicesList[index] = 0;
                                  blankIndex = index;
                                  totalMoves++;
                                }
                                else if((index/gridSize).toInt() == (blankIndex/gridSize).toInt() && (index - blankIndex).abs() == 1){
                                  indicesList[blankIndex] =  indicesList[index];
                                  indicesList[index] = 0;
                                  blankIndex = index;
                                  totalMoves++;
                                }
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.mainColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "${indicesList[index].toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        : SizedBox.shrink();
                  }),
            ),
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
                  "${timePassed.toString()}",
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
                setState(() {
                  indicesList.shuffle();
                  totalMoves = 0;
                  timePassed = 0;
                  blankIndex = indicesList.indexOf(0);
                  isStarted = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
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