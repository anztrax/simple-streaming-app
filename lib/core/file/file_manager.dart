import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TempFileManager{
  File _file;

  TempFileManager();

  Future<void> initFile(String fileName) async{
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempFilePath = "${tempDir.path}/${fileName}";
    _file = File(tempFilePath);
  }

  String getFullFilePath(){
    return _file.path;
  }

  Future<bool> deleteFile() async{
    try {
      await _file.delete();
      return true;
    }catch(ex){
      return false;
    }
  }

  Future<Map> getMapData() async{
    String contents = await _file.readAsString();
    Map jsonMapData = jsonDecode(contents);
    return jsonMapData;
  }
}