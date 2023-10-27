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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBuddyData();
  }

  Future<void> fetchBuddyData() async {
    final response = await http.get(Uri.parse('http://localhost:8010/buddies')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<BuddyData> buddyData = data.map((item) => BuddyData.fromJson(item)).toList();
      setState(() {
        buddies = buddyData;
      });
    }
  }

  void searchBuddies(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, show all buddies
        fetchBuddyData();
      } else {
        // Filter buddies by name based on the search query
        buddies = buddies
            .where((buddy) => buddy.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddies'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) => searchBuddies(query),
                style: TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black), // Set icon color to black
                  hintText: 'Search Buddies',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
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
      color: Colors.blue, // Customize the box's background color
      child: Column(
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
    );
  }
}