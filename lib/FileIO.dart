// ignore: file_names
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:init_tracker/combatant.dart';
import 'package:path_provider/path_provider.dart';

class FileIO {
  FileIO();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(Combatant cb) async {
    String fileName = cb.getName();
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<File> _localSettings() async {
    final path = await _localPath;
    return File('$path/settings.txt');
  }

  Future<File> writeGoal(Combatant cb) async {
    final file = await _localFile(cb);

    Map<String, dynamic> jsonContent = cb.toJson();

    return file.writeAsString(jsonEncode(jsonContent));
  }

  /*Future<File> writeSettings(Settings settings) async {
    final file = await _localSettings();

    Map<String, dynamic> jsonContent = settings.toJson();
    return file.writeAsString(jsonEncode(jsonContent));
  }*/

  Future<String> readInput(File file) async {
    try {
      final contents = await file.readAsString();

      return contents;
    } catch (error) {
      return "";
    }
  }

  void delete(Combatant cb) async {
    File file = await _localFile(cb);
    log(file.toString());
    file.delete();
  }
}
