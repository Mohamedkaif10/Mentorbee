import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mentis_details_page.dart';

class MentiData {
  final String id;
  final String name;
  final String location;
  final String team;

  MentiData({
    required this.id,
    required this.name,
    required this.location,
    required this.team,
  });

  factory MentiData.fromJson(Map<String, dynamic> json) {
    return MentiData(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      team: json['team'],
    );
  }
}

class MentisPage extends StatefulWidget {
  @override
  _MentisPageState createState() => _MentisPageState();
}

class _MentisPageState extends State<MentisPage> {
  List<MentiData> mentis = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMentiData();
  }

  Future<void> fetchMentiData() async {
    final response = await http.get(Uri.parse('http://192.168.31.173:8001/mentis'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<MentiData> mentiData = data.map((item) => MentiData.fromJson(item)).toList();
      setState(() {
        mentis = mentiData;
        isLoading = false; 
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentis'),
      ),
      body: isLoading 
          ? Center(child: CircularProgressIndicator()) 
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: mentis.length,
              itemBuilder: (context, index) {
                final Menti = mentis[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentiDetailsPage(mentiId: Menti.id),
                      ),
                    );
                  },
                  child: MentiBox(Menti: Menti),
                );
              },
            ),
    );
  }
}

class MentiBox extends StatelessWidget {
  final MentiData Menti;

  MentiBox({required this.Menti});

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
          Menti.name,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Text(
          Menti.team,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    ),
  ),
);

  }
}
