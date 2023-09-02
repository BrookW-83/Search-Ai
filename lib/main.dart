import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<Widget> _widgetOptions = <Widget>[
    // Home Screen
    Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.lightGreen, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.lightGreen, // Icon color
                onPressed: () {
                  // Handle search button press
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DuolingoButton(
              icon: Icons.book,
              label: "Definition",
              onPressed: () {
                // Handle Definition button press
              },
            ),
            DuolingoButton(
              icon: Icons.translate,
              label: "Translate",
              onPressed: () {
                // Handle Translate button press
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DuolingoButton(
              icon: Icons.volume_up,
              label: "Text to Speech",
              onPressed: () {
                // Handle Text to Speech button press
              },
            ),
            DuolingoButton(
              icon: Icons.chat,
              label: "Chat",
              onPressed: () {
                // Handle Chat button press
              },
            ),
          ],
        ),
      ],
    ),

    // Calendar Screen (formerly History Screen)
    Center(
      child: Text("Calendar Screen"),
    ),

    // Chat Screen (formerly Exit Screen)
    Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle chat button press
          // You can use Navigator.pop(context); to exit the app.
        },
        child: Text("Chat"),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: BackgroundPainter(),
          ),
          PageView(
            controller: _pageController,
            children: _widgetOptions,
            physics:
                NeverScrollableScrollPhysics(), // Disable swipe between pages
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Changed to Calendar icon
            label: 'Calendar', // Changed to Calendar label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Changed to Chat icon
            label: 'Chat', // Changed to Chat label
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen, // Highlight color
        onTap: _onItemTapped,
      ),
    );
  }
}

class DuolingoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const DuolingoButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // Set button width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Button background color
        border: Border.all(
          color: Colors.lightGreen, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          primary: Colors.white, // Button background color
          elevation: 0, // Remove button elevation
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.lightGreen, // Icon color
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightGreen.withOpacity(0.2); // Color of the wiggly lines
    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}
