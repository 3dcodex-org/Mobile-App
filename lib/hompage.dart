//David
import 'dart:io';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Reader'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open PDF'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PDFListScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PDFListScreen extends StatefulWidget {
  const PDFListScreen({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _PDFListScreenState createState() => _PDFListScreenState();
}

class _PDFListScreenState extends State<PDFListScreen> {
  List<String> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    fetchPDFFiles();
  }

  Future<void> fetchPDFFiles() async {
    String pdfPath = await copyPDFToTempDirectory();

    setState(() {
      pdfFiles = [pdfPath];
    });
  }

  Future<String> copyPDFToTempDirectory() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/agile_prof_CA.pdf';
    ByteData assetData = await rootBundle.load('assets/pdf/agile prof CA .pdf');
    final buffer = assetData.buffer;
    File(tempPath).writeAsBytesSync(
      buffer.asUint8List(assetData.offsetInBytes, assetData.lengthInBytes),
      flush: true,
    );
    return tempPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF List'),
      ),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          String pdfPath = pdfFiles[index];
          return ListTile(
            title: Text(pdfPath),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerScreen(pdfPath: pdfPath),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}