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

  @override
  void initState() {
    super.initState();
    indicesList.shuffle();
    totalSize = gridSize*gridSize;
    blankIndex = indicesList.indexOf(0);
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
            StartButton(),
          ],
        ),
      ),
    );
  }

  void clickGrid(int index) {
    setState(() {
      indicesList[indicesList.indexOf(0)] = indicesList[index];
      indicesList[index] = 0;
    });
  }
}
