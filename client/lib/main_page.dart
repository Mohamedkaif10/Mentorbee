import 'package:flutter/material.dart';
import 'buddies_page.dart'; // Import the BuddiesPage
import 'counselling_page.dart'; // Import the CounsellingPage

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.lime,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              'Welcome to a world of self-care and growth',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          // Center the two boxes with labels and icons
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BoxWithIcon(
                  label: 'Counselling',
                  icon: Icons.chat,
                  backgroundColor: Colors.white,
                  onTap: () {
                    // Navigate to the CounsellingPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentisPage(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 16.0),
                BoxWithIcon(
                  label: 'Buddies',
                  icon: Icons.favorite,
                  backgroundColor: Colors.purple,
                  onTap: () {
                    // Navigate to the BuddiesPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuddiesPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigate to the Home page
            // Update the currentIndex when navigating to the Home page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ThirdPage(),
              ),
            ).then((value) {
              setState(() {
                _currentIndex = 0;
              });
            });
          } else if (index == 1) {
            // Navigate to the Community page
            // Add your community page route here
          } else if (index == 2) {
            // Navigate to the BuddiesPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuddiesPage(),
              ),
            );
          } else if (index == 3) {
            // Navigate to the CounsellingPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MentisPage(),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Buddies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Counselling',
          ),
        ],
      ),
    );
  }
}

class BoxWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  BoxWithIcon({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 8.0),
            Text(label),
          ],
        ),
      ),
    );
  }
}
