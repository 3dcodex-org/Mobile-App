import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const VideoPage(title: 'Video Player'),
    );
  }
}

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _controller;
  // ignore: unused_field
  Future<void>? _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  String? _videoPath;
  String? _videoName;
  String? _videoSize;

  void _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      // Get the app's document directory
      Directory appDirectory = await getApplicationDocumentsDirectory();
      String appPath = appDirectory.path;

      // Copy the selected video file to the app's directory
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      _videoPath = '$appPath/$fileName';
      await file.copy(_videoPath!);

      // Create a new VideoPlayerController using the copied video file
      _controller = VideoPlayerController.file(File(_videoPath!));
      _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
        setState(() {
          _videoName = fileName;
          _videoSize = '${(file.lengthSync() / 1050 / 1050).toStringAsFixed(2)} MB';
        });
      });
    }
  }

  void _showVideoDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // ignore: prefer_const_constructors
          title: Text('Video Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: $_videoName'),
              const SizedBox(height: 8),
              Text('Size: $_videoSize'),
              const SizedBox(height: 8),
              Text('Path: $_videoPath'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _playPauseVideo() {
    if (_controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        _controller!.play();
        setState(() {
          _isPlaying = true;
        });
      }
    }
  }

  void _forwardVideo() {
    if (_controller != null) {
      Duration currentPosition = _controller!.value.position;
      Duration targetPosition = currentPosition + const Duration(seconds: 10);
      _controller!.seekTo(targetPosition);
    }
  }

  void _backwardVideo() {
    if (_controller != null) {
      Duration currentPosition = _controller!.value.position;
      Duration targetPosition = currentPosition - const Duration(seconds: 10);
      _controller!.seekTo(targetPosition);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    // Delete the copied video file
    if (_videoPath != null) {
      File(_videoPath!).delete();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _controller != null
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(_controller!),
                            VideoProgressIndicator(
                              _controller!,
                              allowScrubbing: true,
                              padding: const EdgeInsets.all(8.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _backwardVideo,
                            icon: const Icon(Icons.replay_10),
                          ),
                          IconButton(
                            onPressed: _playPauseVideo,
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                          IconButton(
                            onPressed: _forwardVideo,
                            icon: const Icon(Icons.forward_10),
                          ),
                          IconButton(
                            onPressed: _showVideoDetails,
                            icon: const Icon(Icons.info),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Text(
                  'Choose a video from device ',
                  style: TextStyle(fontSize: 18),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        tooltip: 'Pick Video',
        child: const Icon(Icons.video_library),
      ),
    );
  }
}


