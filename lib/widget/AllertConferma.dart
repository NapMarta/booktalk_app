import 'package:booktalk_app/main.dart';
import 'package:booktalk_app/utils.dart';
import 'package:flutter/material.dart';
    
class AllertConferma extends StatefulWidget {
  const AllertConferma({Key? key}) : super(key: key);

  @override
  _AllertConfermaState createState() => _AllertConfermaState();
}

class _AllertConfermaState extends State<AllertConferma> {

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      width: isTablet(mediaQueryData) ? mediaQueryData.size.width*0.6 : mediaQueryData.size.width*0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Sei sicuro di voler fare il logout?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0097b2)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                    ),
                  ),
                ),
                onPressed: () {
                  // Handle logout action
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => BookTalkApp(),
                    ),
                  ); 
                },
                child: Text('Logout', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text('Annulla', style: TextStyle(color: Color(0xFF0097b2))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}