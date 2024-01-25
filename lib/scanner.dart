// ignore_for_file: file_names, library_prefixes

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const DocumentScannerApp());
}

class DocumentScannerApp extends StatelessWidget {
  const DocumentScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Document Scanner App',
      home: DocumentScanner(),
    );
  }
}

class DocumentScanner extends StatefulWidget {
  const DocumentScanner({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DocumentScannerState createState() => _DocumentScannerState();
}

class _DocumentScannerState extends State<DocumentScanner> {
  List<File> scannedImages = [];

  Future<void> _scanDocument() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        scannedImages.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _generatePdf() async {
    final pdf = pdfWidgets.Document();

    for (var image in scannedImages) {
      final imageWidget = pdfWidgets.Image(
        pdfWidgets.MemoryImage(File(image.path).readAsBytesSync()),
      );
      pdf.addPage(
        pdfWidgets.Page(
          build: (context) {
            return pdfWidgets.Center(child: imageWidget);
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final outputFile = File('${output.path}/scanned_document.pdf');
    await outputFile.writeAsBytes(await pdf.save());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: scannedImages.length,
              itemBuilder: (context, index) {
                return Image.file(scannedImages[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _scanDocument,
                child: const Text('Scan Document'),
              ),
              ElevatedButton(
                onPressed: scannedImages.isNotEmpty ? _generatePdf : null,
                child: const Text('Generate PDF'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
