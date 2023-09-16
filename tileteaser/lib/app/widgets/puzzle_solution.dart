import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tileteaser/app/utils/app_theme.dart';

class PuzzleSolution extends StatefulWidget {
  const PuzzleSolution({
    super.key,
    required this.gridSize,
    required this.path,
  });

  final int gridSize;
  final List<List<int>> path;

  @override
  State<PuzzleSolution> createState() => _PuzzleSolutionState();
}

class _PuzzleSolutionState extends State<PuzzleSolution> {
  int currentListIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${currentListIndex+1}/${widget.path.length}",
        style: GoogleFonts.kaushanScript(
          textStyle: TextStyle(
            color: AppTheme.mainColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),),
        Container(
          width: 250,
          height: 250,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.gridSize,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25),
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.path[currentListIndex].length,
            itemBuilder: (BuildContext context, gridIndex) {
              return widget.path[currentListIndex][gridIndex] != 0
                  ? Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppTheme.mainColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    widget.path[currentListIndex][gridIndex].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
                  : const SizedBox.shrink();
            },
          ),
        ),
        SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentListIndex > 0) {
                    currentListIndex--;
                  }
                });
              },
              child: Container(
                width: 140,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.arrow_back_rounded, color: Colors.white,),
                    Text(
                      'Previous',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentListIndex < widget.path.length - 1) {
                    currentListIndex++;
                  }
                });
              },
              child: Container(
                width: 120,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white,),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
