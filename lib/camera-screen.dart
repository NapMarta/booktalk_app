/*import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booktalk_app/camera.dart';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  final CameraService _cameraService = CameraService();

  // Aggiungi il metodo initializeController
  Future<void> initializeController() async {
    await _cameraService.initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera App')),
      body: FutureBuilder<void>(
        future: initializeController(), // Usa il metodo qui
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraService.controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            final imagePath = await _cameraService.takePicture();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureWidget(imagePath: imagePath),
              ),
            );
          } catch (e) {
            print("Error taking picture: $e");
          }
        },
      ),
    );
  }
}*/
