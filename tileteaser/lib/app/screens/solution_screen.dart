import 'package:flutter/material.dart';
import 'package:tileteaser/app/utils/puzzle_solve_algo.dart';
import 'package:tileteaser/app/widgets/puzzle_solution.dart';

class SolutionScreen extends StatelessWidget {
  SolutionScreen({Key? key,required this.path, required this.gridSize}) : super(key: key);
  static String routeName = '/solution';
  List<List<int>> path;
  int gridSize ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Hints'),
      ),
      body: PuzzleSolution(gridSize: gridSize, path: path,),
    );
  }
}
