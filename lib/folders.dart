import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FoldersWidget extends StatefulWidget {
  const FoldersWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FoldersWidgetState createState() => _FoldersWidgetState();
}

class _FoldersWidgetState extends State<FoldersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateToImagePage() {
    
   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ImagePage(
      imageAssets: [
        '1.png',
        '2.png',
      ],
    ),
  ),
);
  }

  void _navigateToVideoPage() {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const VideoPage(
      videoAssets: [
        'Sequence Diagram.mp4',
        'Flutter Flow.mp4',
      ],
    ),
  ),
);
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              // ignore: avoid_print
              print('IconButton pressed ...');
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  'Files',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 24,
                    color: Theme.of(context).textTheme.titleLarge!.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.folder_open_rounded,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 24,
                        ),
                        onPressed: _navigateToImagePage
                        
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'Images',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                      onPressed: () {
                        _navigateToImagePage();
                      }
                      ),
                      
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon( 
                            Icons.folder_open_rounded,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 24,
                          ),
                          onPressed: () {},
                        ),
                         Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'Music',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon( 
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                       onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        IconButton(
                         icon: Icon( 
                          Icons.folder_open_rounded,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          size: 24,
                        ),
                        onPressed: () {
                          _navigateToVideoPage();
                        },
                        ),
                         Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'Videos',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon( 
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                       onPressed: () {
                        _navigateToVideoPage();
                       },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                         IconButton(
                         icon: Icon( 
                          Icons.folder_open_rounded,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          size: 24,
                        ),
                        onPressed: () {},
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'Xender',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                         IconButton(
                          icon: Icon( 
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                       onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon( 
                            Icons.insert_drive_file_rounded,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 24,
                        ),
                        onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'File 1',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                         IconButton(
                          icon: Icon( 
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                       onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                         IconButton(
                          icon: Icon( 
                            Icons.insert_drive_file_rounded,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 24,
                        ),
                        onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Text(
                            'File 2',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 16,
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon( 
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                            size: 18,
                        ),
                       onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ImagePage extends StatelessWidget {
  final List<String> imageAssets;

  const ImagePage({Key? key, required this.imageAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: imageAssets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle image selection
            },
            child: Image.asset(
              imageAssets[index],
              fit: BoxFit.cover,
              width: 100, // Thumbnail width
              height: 100, // Thumbnail height
            ),
          );
        },
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final List<String> videoAssets;

  const VideoPage({Key? key, required this.videoAssets}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoAssets[_currentVideoIndex]);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _changeVideo(int index) {
    setState(() {
      _currentVideoIndex = index;
      _videoPlayerController = VideoPlayerController.asset(widget.videoAssets[_currentVideoIndex]);
      _initializeVideoPlayerFuture = _videoPlayerController.initialize();
      _videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Video Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(_videoPlayerController),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_videoPlayerController.value.isPlaying) {
                                _videoPlayerController.pause();
                              } else {
                                _videoPlayerController.play();
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.videoAssets.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _changeVideo(index);
                  },
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: Stack(
                            children: [
                              Image.asset(
                                widget.videoAssets[index],
                                fit: BoxFit.cover,
                                width: 100, // Thumbnail width
                                height: 100, // Thumbnail height
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
void main() {
  runApp(const MaterialApp(home: FoldersWidget()));
}

