import 'dart:io';
import 'package:flutter/foundation.dart';
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
      title: 'File Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FileManagerScreen(),
    );
  }
}

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Manager App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'File Management Features',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cleanJunk();
              },
              child: const Text('Clean Junk Files'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cleanJunk() async {
    try {
      // Get the temporary directory path
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Delete files in the temporary directory
      await deleteFilesInDirectory(tempPath);

      // You can add more logic to clean other directories or files
      // For example, cleaning a specific directory:
      // String specificDirectoryPath = '/path/to/specific_directory';
      // await deleteFilesInDirectory(specificDirectoryPath);

      if (kDebugMode) {
        print('Junk cleaning complete.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error cleaning junk: $e');
      }
    }
  }

  Future<void> deleteFilesInDirectory(String directoryPath) async {
    try {
      Directory directory = Directory(directoryPath);

      if (directory.existsSync()) {
        await for (FileSystemEntity entity in directory.list()) {
          if (entity is File) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting files in directory: $e');
      }
    }
  }
}