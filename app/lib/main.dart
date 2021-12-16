import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spliit - Cost splitting made easy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Get Started'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _numPeople = 2;
  Map<int, String> _people = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
                value: _numPeople,
                items: const [
                  DropdownMenuItem(
                    child: Text("Two People"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Three People"),
                    value: 3,
                  )
                ],
                onChanged: (int? value) {
                  setState(() {
                    _numPeople = value!;
                  });
                },
                hint: const Text("Party Size")),
            for (int i = 0; i < _numPeople; ++i)
              TextField(
                  decoration: InputDecoration(labelText: 'Person ${i + 1}'),
                  onChanged: (String value) {
                    _people[i + 1] = value;
                  }),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PageTwo())),
              label: const Text("Next"),
              icon: const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  String endpoint =
      'https://spliit-form-recognizer.cognitiveservices.azure.com/formrecognizer/v2.1/prebuilt/receipt/analyze';
  Uint8List? receipt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Receipt"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
              child: receipt == null
                  ? const Text('No Image Chosen')
                  : Image.memory(
                      receipt!,
                      width: 200,
                      height: 300,
                    )),
          ElevatedButton.icon(
            onPressed: () async {
              var image = await FilePicker.platform.pickFiles();
              if (image != null) {
                setState(() {
                  receipt = image.files.first.bytes;
                });
              }
            },
            icon: const Icon(Icons.camera_enhance_outlined, size: 16),
            label: const Text("Choose Image"),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PageThree())),
            label: const Text("Next"),
            icon: const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
            ),
          ),
        ]),
      ),
    );
  }
}

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
