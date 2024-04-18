import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:async';
import 'package:intl/intl.dart';

String getDayOfWeek(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  return DateFormat('E').format(date); // 'E' represents the abbreviated day of week (e.g., "Mon", "Tue")
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (BuildContext context) {
        return StudentDashboard(
          userType: '',
          userDept: '',
          userName: '',
          userPrn: '',
          userNotify: [],
          userAlloc: [],
        );
      },
    ),
  ));
}

class CustomLoadingScreen extends StatefulWidget {
  @override
  _CustomLoadingScreenState createState() => _CustomLoadingScreenState();
}

class _CustomLoadingScreenState extends State<CustomLoadingScreen> {
  double _size = 150.0;
  bool _isGrowing = true;

  @override
  void initState() {
    super.initState();
    // Start the timer to toggle the size of the logo
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _size = _isGrowing ? 180.0 : 150.0;
        _isGrowing = !_isGrowing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: _size,
            height: _size,
            child: Image.asset(
              'assets/logo.png', // Replace 'logo.png' with your actual image asset path
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class StudentDashboard extends StatefulWidget {
  final String userType;
  final String userDept;
  final String userName;
  final String userPrn;
  final List<String> userNotify;
  final  List<Map<String, dynamic>> userAlloc;
  

  const StudentDashboard({
    Key? key,
    required this.userType,
    required this.userDept,
    required this.userName,
    required this.userPrn,
    required this.userNotify,
    required this.userAlloc,
  }) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool showInvigilationInfo = false;
  late Future<void> _loadingFuture;
  int selectedDateIndex = 0; 
  @override
  void initState() {
    super.initState();
    _loadingFuture = Future.delayed(Duration(seconds: 2)); // Simulating loading for 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Student Dashboard (${widget.userType})',
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text('Logout'),
                      value: 'logout',
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoadingScreen();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    
                    Text(
                      widget.userPrn,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Programme',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    Text(
                      widget.userDept,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Semester',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'CGPA',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'I',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '6.87',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'You have an upcoming exam on ${widget.userAlloc[0]['date']}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        for (var i = 0; i < widget.userAlloc.length; i++)
                          dateButton(
                            widget.userAlloc[i]['date'].split('-').last, // Display only the day part
                            getDayOfWeek(widget.userAlloc[i]['date']), // Function to get day of week
                            true, // Assuming this value should always be true
                            () {
                              setState(() {
                                showInvigilationInfo = true;
                                selectedDateIndex = i; // Update the selected date index
                              });
                            },
                          ),
                      ],
                    ),

                    SizedBox(height: 30),
                    if (showInvigilationInfo) ...[
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              showInvigilationInfo = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFFA0E4C3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'See Alerts',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Raleway'),
                            ),
                          ),
                        ),
                    SizedBox(height: 10),
                          const Text(
                        'Seating plan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            'Examination course code',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.userAlloc[selectedDateIndex]['course_code'], // Display course code for selected date
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Room Name',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.userAlloc[selectedDateIndex]['room_name'], // Display room name for selected date
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child :Text(
                            'Facing this way', 
                            style: TextStyle(fontSize: 18),
                          ),
                          ),
                          Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(height: 20), 
                              BoxGrid(
                                columns: widget.userAlloc[selectedDateIndex]['room_columns'] * 2,
                                rows: widget.userAlloc[selectedDateIndex]['room_rows'],
                                student_row: widget.userAlloc[selectedDateIndex]['student_row'],
                                student_col: widget.userAlloc[selectedDateIndex]['student_col'],
                              ), 
                              SizedBox(height: 20), 
                            ],
                          ),
                        )

                        ],
                        
                      ),
                      
                    ]
                    
                    else ...[
                      
                      Text(
                        'Alerts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.userNotify.length,
                        itemBuilder: (context, index) {
                          return NotificationButton(
                            icon: Icons.notifications_none,
                            message: widget.userNotify[index],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Performance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Semester 1 | CGPA 6.87',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataTable(
                        columnSpacing: 20,
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Course')),
                          DataColumn(label: Text('Grade')),
                          DataColumn(label: Text('SCPA')),
                        ],
                        rows: sampleData
                            .map(
                              (datas) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0),
                                      child: Text(datas[0]),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(datas[1]),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(datas[2]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget dateButton(
    String date, String day, bool isHighlighted, Function() onPressed) {
  return Container(
    padding: isHighlighted ? EdgeInsets.all(4) : null,
    decoration: isHighlighted
        ? BoxDecoration(
            color: Color(0xFFA0E4C3),
            borderRadius: BorderRadius.circular(10),
          )
        : null,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextButton(
  onPressed: onPressed,
  style: TextButton.styleFrom(
    padding: EdgeInsets.only(left: 15, right: 15),
    minimumSize: Size(20, 30),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: isHighlighted ? Color(0xFFA0E4C3) : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        date,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
      Text(
        day,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    ],
  ),
),

        
      ],
    ),
  );
}

class NotificationButton extends StatelessWidget {
  final IconData icon;
  final String message;

  const NotificationButton({Key? key, required this.icon, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Adjusted MainAxisAlignment
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        SizedBox(width: 5),
        Flexible( // Wrap Text with Flexible widget
          child: Text(
            message,
            style: TextStyle(
              fontSize: 13, // Adjust the font size here
            ),
            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Reminder'),
                  content: Text(
                    "This is a reminder for $message",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            'See notification',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
class BoxGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final int student_row;
  final int student_col;

  BoxGrid({required this.rows, required this.columns ,required this.student_row ,required this.student_col});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
              Expanded(child: Box(rowIndex: rowIndex, columnIndex: columnIndex,student_row:student_row,student_col:student_col)),
              Expanded(child: Box(rowIndex: rowIndex, columnIndex: columnIndex + 1,student_row:student_row,student_col:student_col)),
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
  final int student_row;
  final int student_col;

  const Box({required this.rowIndex, required this.columnIndex,required this.student_row,required this.student_col});

  @override
  Widget build(BuildContext context) {
    bool isGreen = rowIndex == student_row && columnIndex  == student_col; // Check if the box should be green
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: isGreen ? Color(0xFFA0E4C3) : Colors.white, // Change the color of the box if it should be green
      ),
      height: 20, // Adjust the size of the box as needed
    );
  }
}
const List<List<String>> sampleData = [
  ['CCRCP05 - Optimization teChniques', 'A', '6.89'],
  ['COPCU70 - Fundamentals of Digital Science ', 'A', '4'],
  ['Physics', 'B', '3'],
  ['Computer Science', 'A', '3'],
  ['English', 'C', '3'],
];