// Madick
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      home: const ImagePage(),
    );
  }
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Camera', 'Screenshots', 'Received'];
  Set<String> selectedImages = {};
  List<File> images = [];
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    // Load images automatically when the app starts
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Image Page'),
        leading: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          // Space for previewing selected image
          SizedBox(
            height: 200, // Adjust the height as needed
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    fit: BoxFit.contain,
                  )
                : const Center(
                    child: Text('No image selected'),
                  ),
          ),
          // Space for category and dropdown button
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Category:',
                  style: TextStyle(fontSize: 18.0),
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                    loadImages();
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // Space for fetching and displaying all images
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _previewImage(images[index]);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.file(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          // Space for buttons
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Implement common action - Copy
                    copyFiles(selectedImages);
                  },
                  child: const Text('Copy'),
                ),
                TextButton(
                  onPressed: () {
                    // Implement common action - Cut
                    cutFiles(selectedImages);
                  },
                  child: const Text('Cut'),
                ),
                TextButton(
                  onPressed: () {
                    // Implement common action - Paste
                    pasteFiles(selectedImages, selectedCategory);
                  },
                  child: const Text('Paste'),
                ),
                TextButton(
                  onPressed: () {
                    // Implement common action - Delete
                    deleteFiles(selectedImages);
                  },
                  child: const Text('Delete'),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Implement More option actions
                    switch (value) {
                      case 'Hide':
                        hideImages(selectedImages);
                        break;
                      case 'Lock':
                        lockImages(selectedImages);
                        break;
                      case 'Share':
                        shareImages(selectedImages);
                        break;
                      case 'Rename':
                        renameImage(selectedImages.first);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Hide', 'Lock', 'Share', 'Rename']
                        .map((String option) {
                      return PopupMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void copyFiles(Set<String> files) {
    showToast('Copy files: $files');
    for (var file in files) {
      File originalFile = File(file);
      String fileName = originalFile.path.split('/').last; // Extract file name
      File copyFile = File('${originalFile.parent.path}/Copy_$fileName');
      originalFile.copySync(copyFile.path);
    }
  loadImages();
  }

  void cutFiles(Set<String> files) {
    showToast('Cut files: $files');
    for (var file in files) {
      File originalFile = File(file);
      String fileName = originalFile.path.split('/').last; // Extract file name
      File tempStorage = File('${originalFile.parent.path}/TempStorage/$fileName');
      originalFile.renameSync(tempStorage.path);
    }
  loadImages();
  }

  void pasteFiles(Set<String> files, String category) {
    showToast('Paste files to category $category: $files');
    for (var file in files) {
      File originalFile = File(file);
      String fileName = originalFile.path.split('/').last; // Extract file name
      File destinationFile = File('$category/$fileName');
      originalFile.copySync(destinationFile.path);
    }
    loadImages();
  }

  void deleteFiles(Set<String> files) {
    showToast('Delete files: $files');
    for (var file in files) {
      File deleteFile = File(file);
      deleteFile.deleteSync();
    }
    loadImages();
  }

  void hideImages(Set<String> images) {
    showToast('Hide images: $images');
    for (var image in images) {
      File originalImage = File(image);
    String imageName = originalImage.path.split('/').last; // Extract file name
    File hiddenFolder = File('${originalImage.parent.path}/.Hidden');
    hiddenFolder.createSync(); // Create hidden folder if not exists
    File hiddenImage = File('${hiddenFolder.path}/$imageName');
    originalImage.renameSync(hiddenImage.path);
    }
    loadImages();
  }

  void lockImages(Set<String> images) {
    showToast('Lock images: $images');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PasswordDialog(
          onPasswordEntered: (String enteredPassword) {
            // You can perform additional checks or use the password as needed
            showToast('Images locked with password: $enteredPassword');
          },
        );
      },
    );
  }

  void shareImages(Set<String> images) {
    showToast('Share images: $images');
    List<String> paths = List.from(images);
    Share.shareFiles(paths, text: 'Sharing images');
  }

  void renameImage(String image) {
    showToast('Rename image: $image');
    File originalImage = File(image);
    String imageName = originalImage.path.split('/').last; // Extract file name
    String newName = 'New_$imageName';
    originalImage.renameSync('${originalImage.parent.path}/$newName');
    loadImages();
  }

  Future<void> loadImages() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        showToast('Permission denied');
        return;
      }
    }

    List<XFile>? result = await ImagePicker().pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (result != null) {
      setState(() {
        images = result.map((file) => File(file.path)).toList();
      });
    }
  }

  void _previewImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }
}

class PasswordDialog extends StatefulWidget {
  final Function(String)? onPasswordEntered;

  const PasswordDialog({super.key, this.onPasswordEntered});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Password'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Password',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String enteredPassword = _passwordController.text;
            widget.onPasswordEntered?.call(enteredPassword);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}