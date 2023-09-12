import 'package:flutter/material.dart';

class PuzzleLayout extends StatefulWidget {
  PuzzleLayout({
    super.key,
    this.gridSize = 9,
    required this.mainColor,
    required this.indices,
    required this.blankIndex,
  });

  final Color mainColor;
  final List<int> indices;
  int blankIndex;
  final int gridSize;

  @override
  State<PuzzleLayout> createState() => _PuzzleLayoutState();
}

class _PuzzleLayoutState extends State<PuzzleLayout> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1/1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: widget.gridSize,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                if(index% widget.gridSize == widget.blankIndex%widget.gridSize && (index - widget.blankIndex).abs() == 3){
                  setState(() {
                    widget.indices[widget.blankIndex] = widget.indices[index];
                    widget.indices[index] = 0;
                    widget.blankIndex = index;
                  });
                }
                else if (index/widget.gridSize == widget.blankIndex/widget.gridSize && (index - widget.blankIndex).abs() == 1){
                  setState(() {
                    widget.indices[widget.blankIndex] = widget.indices[index];
                    widget.indices[index] = 0;
                    widget.blankIndex = index;
                  });
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.indices[index] != 0 ?widget.mainColor: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "${widget.indices[index]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            );
          }),
    );
  }
}
