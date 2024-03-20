import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:async';
import 'package:intl/intl.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (BuildContext context) {
        return TeacherDashboard(
          userType: '',
          userDept: '',
          userName: '',
          userPrn: '',
          userNotify: [''], // Example notifications
          userAlloc: [], // Example notifications
        );
      },
    ),
  ));
}

String getDayOfWeek(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  return DateFormat('E').format(date); // 'E' represents the abbreviated day of week (e.g., "Mon", "Tue")
}

class TeacherDashboard extends StatefulWidget {
  final String userType;
  final String userDept;
  final String userName;
  final String userPrn;
  final List<String> userNotify;
  final  List<Map<String, dynamic>> userAlloc;

  const TeacherDashboard({
    Key? key,
    required this.userType,
    required this.userDept,
    required this.userName,
    required this.userPrn,
    required this.userNotify,
    required this.userAlloc,
  }) : super(key: key);

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
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

class _TeacherDashboardState extends State<TeacherDashboard> {
  bool showInvigilationInfo = false;
  late Future<void> _loadingFuture;
  int selectedDateIndex = 0; 
  int fridayCounter = 0; 

  @override
  void initState() {
    super.initState();
    countFridays();
    _loadingFuture = Future.delayed(Duration(seconds: 2)); // Simulating loading for 2 seconds
  }
void countFridays() {
    for (int i = 0; i < widget.userAlloc.length; i++) {
      String date = widget.userAlloc[i]['date']; // Extract the date from userAlloc
      String dayOfWeek = getDayOfWeek(date); // Get the day of the week using the provided function
      if (dayOfWeek == 'Fri') { // Check if it's Friday
        fridayCounter++; // Increment the counter if it's a Friday
      }
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Teacher Dashboard',
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    SizedBox(height: 15),
                    const Text(
                      'Department',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    Text(
                      widget.userDept,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 15),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Number of Duties',
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
                            'Friday duties',
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
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${widget.userAlloc.length}',
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
                            '${fridayCounter}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                     Text(
                      'You have an upcoming invigilation duty on ${widget.userAlloc[0]['date']}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    const Text(
                      'Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      for (var i = 0; i < widget.userAlloc.length; i++)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), // Adjust the horizontal spacing as needed
          child: dateButton(
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
        ),
    ],
  ),
),

                    SizedBox(height: 20),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                          Text(
                            'Mark Attendance', // Display room name for selected date
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                         ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.userAlloc[selectedDateIndex]['student_prns'].length,
                            itemBuilder: (BuildContext context, int index) {
                              var prn = widget.userAlloc[selectedDateIndex]['student_prns'][index];

                              return Row(
                                children: [
                                  Text(prn, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)), // Adjust text size
                                  SizedBox(width: 100), // Adjust as needed
                                  TextButton(
                                    onPressed: () {
                                      // Handle accept button press for student PRN
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF74D4A6)),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      minimumSize: MaterialStateProperty.all<Size>(Size(35, 25)), // Adjust button size
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 8)), // Adjust text padding
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6), // Adjust border radius
                                        ),
                                      ),
                                    ),
                                    child: Text('Present', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)), // Adjust button text size
                                  ),
                                  SizedBox(width: 5), // Adjust as needed
                                  TextButton(
                                    onPressed: () {
                                      // Handle reject button press for student PRN
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE46D6D)),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      minimumSize: MaterialStateProperty.all<Size>(Size(35, 25)), // Adjust button size
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 8)), // Adjust text padding
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6), // Adjust border radius
                                        ),
                                      ),
                                    ),
                                    child: Text('Absent', style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold)), // Adjust button text size
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ] else ...[
                      const Text(
                        'Alerts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      SizedBox(height: 15),
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
                      const Text(
                        'Previous Duty Info',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              '14/02/2024 - Monday',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'F01',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              '02/02/2024 - Tuesday',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Auditorium',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ),
                        ],
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
}

class NotificationButton extends StatelessWidget {
  final IconData icon;
  final String message;

  const NotificationButton({
    Key? key,
    required this.icon,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        SizedBox(width: 5),
        Flexible(
          child: Text(
            message,
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: () {
            showDutyExchangeDialog(context);
          },
          child: const Text(
            'See details',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

void showDutyExchangeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Duty Exchange Request From Don Joe'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'Request for exchange of duty on 27/02/2024',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF74D4A6),
                      onPrimary: Colors.white,
                      minimumSize: Size(100, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Accept'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE46D6D),
                      onPrimary: Colors.white,
                      minimumSize: Size(100, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Decline'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
