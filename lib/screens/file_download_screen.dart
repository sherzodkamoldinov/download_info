
import 'package:flutter/material.dart';


class FileDownloadScreen extends StatefulWidget {
  const FileDownloadScreen({super.key});

  @override
  State<FileDownloadScreen> createState() => _FileDownloadScreenState();
}

class _FileDownloadScreenState extends State<FileDownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("File download "),
      ),
      body: ListView(
        children: List.generate(4, (index) => ListTile(
          title: Text("Price "),
          leading: Image.network("Image url keladi"),
          subtitle:LinearProgressIndicator(
              // value: state.progress,
              backgroundColor: Colors.black,
            ) ,
        )),
      ),
    );
  }
}