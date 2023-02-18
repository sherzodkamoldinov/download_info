import 'package:download_info/cubit/file_download_cubit.dart';
import 'package:download_info/data/models/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_safe/open_file_safe.dart';

class SingleFileDownload extends StatelessWidget {
  SingleFileDownload({Key? key, required this.fileInfo}) : super(key: key);

  final ProductModel fileInfo;
  FileManagerCubit fileManagerCubit = FileManagerCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          return ListTile(
            leading: state.progress == 0
                ? const Icon(Icons.filter_drama_rounded)
                : CircularProgressIndicator(
                    value: state.progress,
                    backgroundColor: Colors.grey,
                  ),
            title: Text(fileInfo.name),
            subtitle: Text("${fileInfo.price} \$"),
            onTap: () {
              if (state.newFileLocation.isNotEmpty) {
                OpenFile.open(state.newFileLocation);
              } else {
                context
                    .read<FileManagerCubit>()
                    .downloadIfExists(productModel: fileInfo);
              }
            },
            trailing: IconButton(
              onPressed: () {
                if (state.newFileLocation.isNotEmpty) {
                  print(state.newFileLocation);
                  OpenFile.open(state.newFileLocation);
                }
              },
              icon: const Icon(Icons.open_in_new_rounded),
            ),
          );
        },
      ),
    );
  }
}
