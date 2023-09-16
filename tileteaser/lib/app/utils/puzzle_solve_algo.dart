import 'package:collection/collection.dart';

class StateNode {
  List<int> currentState = [];
  int heuristic = 0;
  int blankIndex = 0;
  int depth = 0;
  int cost = 0;
  List<List<int>> changeableTiles = [];
  List<List<int>> path = [];
  int gridSize = 3;

  StateNode(this.currentState, List<int> finalState, this.depth, this.path,
      this.gridSize) {
    heuristic = getHeuristic(finalState);
    blankIndex = currentState.indexOf(0);
    cost = heuristic + depth;
    changeableTiles = getChangeableTiles();
  }

  int getHeuristic(List<int> finalState) {
    int localHeuristic = 0;
    for (int i = 0; i < currentState.length; i++) {
      if (currentState[i] != finalState[i] && currentState[i] != 0) {
        localHeuristic++;
      }
    }
    return localHeuristic;
  }

  bool isFinalState(List<int> finalState) {
    for (int i = 0; i < currentState.length; i++) {
      if (currentState[i] != finalState[i]) {
        return false;
      }
    }
    return true;
  }

  List<List<int>> getChangeableTiles() {
    List<List<int>> chList = [];
    List<int> stateNode = [];

    // Check if the blank tile is not in the first row then swap it with the tile above it
    if (blankIndex ~/ gridSize != 0) {
      stateNode = List.from(currentState);
      stateNode[blankIndex] = stateNode[blankIndex-gridSize];
      stateNode[blankIndex-gridSize] = 0;
      chList.add(stateNode);
    }

    // Check if the blank tile is not in the last row then swap it with the tile below it
    if (blankIndex ~/ gridSize != gridSize - 1) {
      stateNode = List.from(currentState);
      stateNode[blankIndex] = stateNode[blankIndex + gridSize];
      stateNode[blankIndex + gridSize] = 0;
      chList.add(stateNode);
    }

    // Check if the blank tile is not in the first column then swap it with the tile left to it
    if (blankIndex % gridSize != 0) {
      stateNode = List.from(currentState);
      stateNode[blankIndex] = stateNode[blankIndex -1];
      stateNode[blankIndex-1] = 0;
      chList.add(stateNode);
    }

    // Check if the blank tile is not in the last column then swap it with the tile right to it
    if (blankIndex % gridSize != gridSize - 1) {
      stateNode = List.from(currentState);
      stateNode[blankIndex] = stateNode[blankIndex+1];
      stateNode[blankIndex+1] = 0;
      chList.add(stateNode);
    }
    return chList;
  }
}

List<List<int>> solvePuzzle(List<int> initialState, int gridSize) {
  List<int> finalState = [];
  for (int i = 1; i < gridSize * gridSize; i++) {
    finalState.add(i);
  }
  finalState.add(0);

  PriorityQueue<StateNode> queue =
  PriorityQueue<StateNode>((a, b) => a.cost.compareTo(b.cost));
  queue.add(StateNode(initialState, finalState, 0, [initialState], gridSize));
  while (queue.isNotEmpty) {
    StateNode state = queue.removeFirst();
    if (state.isFinalState(finalState)) {
      return state.path;
    }
    if(state.path.length == 10){
      return state.path;
    }
    queue.addAll(state.changeableTiles.map((nextState) => StateNode(nextState,
        finalState, state.depth + 1, state.path + [nextState], gridSize)));
  }
  return [];
}