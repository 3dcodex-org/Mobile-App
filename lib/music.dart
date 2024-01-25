import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyA());
}

// ignore: use_key_in_widget_constructors
class MyA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> allFiles = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLoadFiles();
  }

  Future<void> _checkPermissionsAndLoadFiles() async {
    // Check if the required permission is granted
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      // Permission is already granted, load the files
      _loadFiles();
    } else {
      // Request permission
      if (await Permission.storage.request().isGranted) {
        // Permission granted, load the files
        _loadFiles();
      } else {
        // ignore: avoid_print
        print("Permission denied");
      }
    }
  }

  Future<void> _loadFiles() async {
    try {
      // Get the documents directory
      Directory? documentsDirectory = await getExternalStorageDirectory();
      List<FileSystemEntity> files =
          Directory(documentsDirectory!.path).listSync(recursive: true);

      // Filter all files
      allFiles = files.map((file) => file.path).toList();

      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print("Error loading files: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> musicFiles = allFiles
        .where((file) => file.toLowerCase().endsWith('.mp3'))
        .toList();

    List<String> pdfFiles = allFiles
        .where((file) => file.toLowerCase().endsWith('.pdf'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('File Preview'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: prefer_const_constructors
            child: Text(
              'Music Files:',
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: musicFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(musicFiles[index]),
                );
              },
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: prefer_const_constructors
            child: Text(
              'PDF Files:',
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pdfFiles[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

