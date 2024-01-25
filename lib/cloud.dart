//Mbah David
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'File Manager Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;
  String _internalStorageSpace = '';
  int _fileFolderCount = 10;

  @override
  void initState() {
    super.initState();
    _getInternalStorageSpace();
    _getFileFolderCount();
  }


Future<void> _getInternalStorageSpace() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = appDocDir.path;
  
  int freeSpace = await Directory(path)
      .list(recursive: true)
      .map((file) => file.statSync().size)
      .fold(0, (prev, element) => prev + element);
  
  setState(() {
    _internalStorageSpace = _formatBytes(freeSpace);
  });
}
  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (bytes == 0) ? 0 : (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${sizes[i]}';
  }

  void _getFileFolderCount() {
    // Replace with your logic to fetch the actual file/folder count
    setState(() {
      _fileFolderCount = 20; // Example value
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 57, 167),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            Text(
              'Internal Storage: $_internalStorageSpace',
              style: const TextStyle(fontSize: 200),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Internal Storage'),
              subtitle: Text(_internalStorageSpace),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _fileFolderCount,
              itemBuilder: (context, index) {
                // Replace with custom file/folder item widget
                return GestureDetector(
                  onTap: () {
                    // Handle file/folder item tap
                  },
                  child: const Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder), // Replace with appropriate icon
                        SizedBox(height: 10),
                        Text(
                          'File/Folder Name',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}