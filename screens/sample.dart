import 'package:flutter/material.dart';

void main() {
  runApp(BoxGridApp());
}

class BoxGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Box Grid Example'),
        ),
        body: BoxGrid(rows: 6, columns: 12), // Set the number of rows and columns
      ),
    );
  }
}

class BoxGrid extends StatelessWidget {
  final int rows;
  final int columns;

  BoxGrid({required this.rows, required this.columns});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: rows * columns, // Total number of boxes
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
      ),
      itemBuilder: (BuildContext context, int index) {
        int rowIndex = index ~/ columns;
        int columnIndex = index % columns;
        // If columnIndex is even, return a pair of boxes; otherwise, return an empty container
        if (columnIndex % 2 == 0) {
          return Row(
            children: [
              Expanded(child: Box(rowIndex: rowIndex, columnIndex: columnIndex)),
              Expanded(child: Box(rowIndex: rowIndex, columnIndex: columnIndex + 1)),
            ],
          );
        } else {
          return Container(); // Empty container for odd column indices
        }
      },
    );
  }
}

class Box extends StatelessWidget {
  final int rowIndex;
  final int columnIndex;

  const Box({required this.rowIndex, required this.columnIndex});

  @override
  Widget build(BuildContext context) {
    bool isGreen = rowIndex % 2 == 0 && columnIndex % 2 == 0; // Check if the box should be green
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: isGreen ? Colors.green : Colors.white, // Change the color of the box if it should be green
      ),
      height: 30, // Adjust the size of the box as needed
    );
  }
}
