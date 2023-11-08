import 'package:flutter/material.dart';
import 'payment_page.dart';

class BookAppointmentPage extends StatefulWidget {
  final Map<String, dynamic> buddyDetails;
  final String sessionPrice;

   BookAppointmentPage({required this.buddyDetails,  this.sessionPrice=''});

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  String sessionDay = 'Today'; // Default value
  String sessionDuration = '30 Minutes'; // Default value
  String sessionTime = '5:00 PM'; // Default value
 int sessionPrice = 0;

  Map<String, String> durationPrices = {
    '20 Minutes': '1 rupees',
    '30 Minutes': '70 rupees',
    '40 Minutes': '80 rupees',
    '50 Minutes': '100 rupees',
    '60 Minutes': '120 rupees',
  };

  Widget getGestureContainer(String text, Function() onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : null,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Color.fromARGB(255, 205, 200, 200),
            width: 2.0,
          ),
        ),
        child: Text(
          text,
          style:
              TextStyle(fontSize: 18, color: isSelected ? Colors.white : null),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buddy Name: ${widget.buddyDetails['name'] ?? 'Loading...'}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Select Session Day:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  getGestureContainer('Today', () {
                    setState(() {
                      sessionDay = 'Today';
                    });
                  }, sessionDay == 'Today'),
                  getGestureContainer('Tomorrow', () {
                    setState(() {
                      sessionDay = 'Tomorrow';
                    });
                  }, sessionDay == 'Tomorrow'),
                ],
              ),
              Row(
                children: [
                  getGestureContainer('Day After Tomorrow', () {
                    setState(() {
                      sessionDay = 'Day After Tomorrow';
                    });
                  }, sessionDay == 'Day After Tomorrow'),
                ],
              ),
              Text(
                'Session Duration:',
                style: TextStyle(fontSize: 18),
              ),
              Wrap(
                children: durationPrices.keys.map((duration) {
                  return getGestureContainer(duration, () {
                    setState(() {
                      sessionDuration = duration;
                       sessionPrice = int.tryParse(durationPrices[sessionDuration]?.split(' ')[0] ?? '0') ?? 0;
                    });
                  }, sessionDuration == duration);
                }).toList(),
              ),
              Text(
                'Select Session Time:',
                style: TextStyle(fontSize: 18),
              ),
              Wrap(
                children: <Widget>[
                  getGestureContainer('5:00 PM', () {
                    setState(() {
                      sessionTime = '5:00 PM';
                    });
                  }, sessionTime == '5:00 PM'),
                  getGestureContainer('6:00 PM', () {
                    setState(() {
                      sessionTime = '6:00 PM';
                    });
                  }, sessionTime == '6:00 PM'),
                  getGestureContainer('7:00 PM', () {
                    setState(() {
                      sessionTime = '7:00 PM';
                    });
                  }, sessionTime == '7:00 PM'),
                  getGestureContainer('8:00 PM', () {
                    setState(() {
                      sessionTime = '8:00 PM';
                    });
                  }, sessionTime == '8:00 PM'),
                  getGestureContainer('9:00 PM', () {
                    setState(() {
                      sessionTime = '9:00 PM';
                    });
                  }, sessionTime == '9:00 PM'),
                ],
              ),
              if (sessionPrice!=0)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(255, 79, 145, 199),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '$sessionPrice rupees',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Change the border radius here
                    ),
                  ),
                ),
                onPressed: () {
                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaymentPage (amount: sessionPrice),
                    ),
                  );
                  // Add your appointment booking logic here
                },
                child: Text('Pay', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
