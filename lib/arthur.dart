import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'File Operations Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _fileNameController = TextEditingController();
  String _basePath = "";

  @override
  void initState() {
    super.initState();
    _initBasePath();
  }

  Future<void> _initBasePath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _basePath = directory.path;
    });
  }

  Future<void> _createFile(String fileName) async {
    final file = File('$_basePath/$fileName.txt');
    await file.create();
    // ignore: avoid_print
    print('File created: ${file.path}');
  }

  Future<void> _renameFile(String oldFileName, String newFileName) async {
    final oldFile = File('$_basePath/$oldFileName.txt');
    final newFile = File('$_basePath/$newFileName.txt');
    await oldFile.rename(newFile.path);
    // ignore: avoid_print
    print('File renamed: ${newFile.path}');
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      // ignore: avoid_print
      print('File selected: ${file.path}');
    } else {
      // User canceled the picker
      // ignore: avoid_print
      print('File selection canceled');
    }
  }

  Future<void> _deleteFile(String fileName) async {
    final file = File('$_basePath/$fileName.txt');
    await file.delete();
    // ignore: avoid_print
    print('File deleted: ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Operations Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(labelText: 'Enter File Name'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _createFile(_fileNameController.text),
                  child: const Text('Create File'),
                ),
                ElevatedButton(
                  onPressed: () => _renameFile('oldName', 'newName'),
                  child: const Text('Rename File'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _selectFile,
                  child: const Text('Select File'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteFile(_fileNameController.text),
                  child: const Text('Delete File'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}