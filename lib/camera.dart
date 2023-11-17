import 'dart:io';

import 'package:booktalk_app/profilo.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile _imageFile;

  @override
  void initState() {
    super.initState();

    // Initialize the camera
    _controller = CameraController(
      CameraDescription(
        name: "0",
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90,
      ),
      ResolutionPreset.medium,
    );

    // Initialize the controller asynchronously
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Release the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      /*appBar: AppBar(title: Text('Camera App')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If initialization is complete, show the camera preview
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),*/

      // ------ HEADER ------
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0097b2),), // Icona personalizzata
            onPressed: () {
              Navigator.of(context).pop(); // Torna indietro alla schermata precedente
            },
          ),  

          title: Text(
            'Risoluzione espressione',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.white,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Image.asset('assets/person-icon.png'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                    ),
                  ); 
                },
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,

      body: Column(
      children: [
        SizedBox(height: 120,),
        FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If initialization is complete, show the camera preview
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      SizedBox(height: 20,),
      Container(
          //alignment: Alignment.bottomRight,
        child: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            // Wait for the controller to be initialized before taking a photo
            await _initializeControllerFuture;

            // Take a photo and get the XFile of the saved image
            XFile imageFile = await _controller.takePicture();

            // Display the taken picture
            setState(() {
              _imageFile = imageFile;
            });

            // Open the review screen
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewPictureScreen(imageFile: _imageFile),
              ),
            );

            // Handle the result from the review screen
            if (result != null && result) {
              // User accepted the picture, add your logic here
              print('Picture accepted');
            } else {
              // User rejected the picture, add your logic here
              print('Picture rejected');
            }
          } catch (e) {
            print("Error taking a photo: $e");
          }
        },
      ),
      ),
      ],
      ),
      ),
    );
  }
}

class ReviewPictureScreen extends StatelessWidget {
  final XFile imageFile;

  const ReviewPictureScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Picture')),
      body: Column(
        children: [
          Image.file(File(imageFile.path)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement logic for accepting the picture
                  Navigator.pop(context, true);
                },
                child: Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement logic for rejecting the picture
                  Navigator.pop(context, false);
                },
                child: Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
