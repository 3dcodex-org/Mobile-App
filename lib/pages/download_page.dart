import 'package:flutter/material.dart';

class File { 
  final String name;
  final String tag;
  final double size; // Updated size property to double type

  File({            // indicates that the constructor is for a class named File
    required this.name,     // named parameter that refer to the instance variables
    required this.tag,      // named parameter that refer to the instance variables
    required this.size,     // named parameter that refer to the instance variables
  });
}

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override   //annotation in Dart that indicates that the following method is intended to override a method from a superclass or an interface
  // ignore: library_private_types_in_public_api
  _DownloadPageState createState() => _DownloadPageState();    //createState, creates and returns the corresponding state object for the DownloadPage widget
}

class _DownloadPageState extends State<DownloadPage> {
  List<File> files = [                //declares and initializes a list of File objects named files
    File(name: 'Battle Field', tag: 'Shooting', size: 0.1),
    File(name: 'DBZ Budokai', tag: 'Fighters', size: 0.5),
    File(name: 'Naruto Impact', tag: 'Adventure', size: 0.3),
    File(name: 'Genshin Impact', tag: 'Adventure', size: 1.2),
    File(name: 'SUBWAY SURFERS', tag: 'Fighters', size: 0.8),
  ];
 
  List<File> filteredFiles = [];               // declares and initializes an empty list named filteredFiles of type List<File>

  String searchTerm = '';                     //declares a variable named searchTerm of type String and it is initialised with an empty string

  @override
  void initState() {
    super.initState();
    filteredFiles = files;
  }

  void sortFilesByName() {                     //sorts the filteredFiles list by the name property of the File objects
    setState(() {
      filteredFiles.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortFilesByTag() {                     //sorts the filteredFiles list by the tag property of the File objects
    setState(() {
      filteredFiles.sort((a, b) => a.tag.compareTo(b.tag));      //compareTo method is used to compare the names of two File objects (a and b) and determine their order in the sorted list
    });                                                            //filteredFiles list is used to sort the list in ascending order based on the name property
  }

  void sortFilesBySize() {
    setState(() {
      filteredFiles.sort((a, b) => a.size.compareTo(b.size));
    });
  }

  void searchFiles(String term) {
    setState(() {
      searchTerm = term;
      filteredFiles = files
          .where((file) => file.name.toLowerCase().contains(term.toLowerCase()))      //used to ensure case-insensitive comparison.
          .toList();                            //used to convert the filtered results, which are initially returned as an iterable, into a list.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(                    //widget that provides a basic structure for a material design app. It typically includes an app bar, a body, and other optional components like drawers, tabs
      appBar: AppBar(                   //property used to specify the app bar for the scaffold
        title: const Text('Download Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchFiles,
              decoration: const InputDecoration(                          //This property is used to add visual styling to the TextField. In this case, it provides a label text of 'Search' and an icon of a search magnifying glass.
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: sortFilesByName,
                child: const Text('Sort by Name'),
              ),
              ElevatedButton(
                onPressed: sortFilesByTag,
                child: const Text('Sort by Tag'),
              ),
              ElevatedButton(
                onPressed: sortFilesBySize,
                // ignore: sort_child_properties_last
                child: const Text('Sort by Size'),
                style: ElevatedButton.styleFrom(
              
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFiles.length,
              itemBuilder: (context, index) {
                final file = filteredFiles[index];
                return ListTile(
                  title: Text(file.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tag: ${file.tag}'),
                      Text('Size: ${file.size.toStringAsFixed(2)} GB'),
                    ],
                  ),
                  trailing: const Icon(Icons.download),
                  onTap: () {
                    // Handle file download
                  },
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
  runApp(const MyApp());                        //starts the Flutter application with the MyApp widget as the root.
}                                          //MyApp(): This is the constructor call for the MyApp class. It creates an instance of the MyApp widget, which was defined earlier, and passes it as an argument to runApp to start the Flutter application

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(                     //This widget is a top-level widget that provides the overall structure and configuration for a Material Design application
      title: 'Download App',
      theme: ThemeData(                    //used to define the theme for the application
        primarySwatch: Colors.blue,
      ),
      home: const DownloadPage(),              //used to specify the default home page of the application
    );
  }
}
