import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:download_info/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'file_download_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit()
      : super(
          FileManagerState(
            progress: 0.0,
            newFileLocation: "",
          ),
        );

  void downloadIfExists({
    required ProductModel productModel,
  }) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    var directory = await getDownloadPath();

    String url = productModel.fileUrl;
    String newFileLocation =
        "${directory?.path}/${productModel.name}${DateTime.now().millisecond}${url.substring(url.length - 5, url.length)}";

    try {
      await Dio().download(url, newFileLocation,
          onReceiveProgress: (received, total) {
        var pr = received / total;
        emit(state.copyWith(progress: pr));
      });
      emit(state.copyWith(newFileLocation: newFileLocation));
    } catch (error) {
      debugPrint("DOWNLOAD ERROR:$error");
    }

  }


  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }
  
}
