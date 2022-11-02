import 'package:download_info/data/models/product_model.dart';
import 'package:download_info/data/service/api_client.dart';
import 'package:download_info/data/service/api_provider.dart';
import 'package:download_info/widgets/file_download_item.dart';
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
      appBar: AppBar(
        title: const Text("File download "),
      ),
      body: FutureBuilder<List<ProductModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var products = snapshot.data!;
            return ListView(
              children: List.generate(products.length, (index) {
                var singleFile = products[index];
                return SingleFileDownload(fileInfo: singleFile);
              }),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        },
        future: ApiService(apiClient: ApiClient()).getProducts(),
      ),
    );
  }
}
