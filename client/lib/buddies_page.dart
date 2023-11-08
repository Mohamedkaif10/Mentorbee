import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'buddies_details_page.dart';

class BuddyData {
  final String id;
  final String name;
  final String location;
  final String team;

  BuddyData({
    required this.id,
    required this.name,
    required this.location,
    required this.team,
  });

  factory BuddyData.fromJson(Map<String, dynamic> json) {
    return BuddyData(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      team: json['team'],
    );
  }
}

class BuddiesPage extends StatefulWidget {
  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  List<BuddyData> buddies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBuddyData();
  }

  Future<void> fetchBuddyData() async {
    final response = await http.get(Uri.parse('http://192.168.31.173:8001/buddies'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<BuddyData> buddyData = data.map((item) => BuddyData.fromJson(item)).toList();
      setState(() {
        buddies = buddyData;
        isLoading = false; 
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddies'),
      ),
      body: isLoading 
          ? Center(child: CircularProgressIndicator()) 
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: buddies.length,
              itemBuilder: (context, index) {
                final buddy = buddies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuddyDetailsPage(buddyId: buddy.id),
                      ),
                    );
                  },
                  child: BuddyBox(buddy: buddy),
                );
              },
            ),
    );
  }
}

class BuddyBox extends StatelessWidget {
  final BuddyData buddy;

  BuddyBox({required this.buddy});

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: EdgeInsets.all(8.0),
  padding: EdgeInsets.all(16.0),
  color: Colors.blue, 
  child: SizedBox(
    height: 100, 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Text(
          buddy.name,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Text(
          buddy.team,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    ),
  ),
);

  }
}
