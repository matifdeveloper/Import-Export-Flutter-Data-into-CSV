import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> {
  late List<List<dynamic>> data;
  List<PlatformFile>? _paths;
  String? extension = 'csv';
  final _fileType = FileType.custom;

  @override
  void initState() {
    super.initState();
    data = List<List<dynamic>>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.pink,
                height: 30,
                child: TextButton(
                  onPressed: _openFileExplorer,
                  child: const Text(
                    "CSV To List",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(data[index][0]),
                  subtitle: Text(data[index][1]),
                  trailing: Text(data[index][2]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  openFile(filePath) async {
    File file = File(filePath);
    print("CSV to List");
    final data = file.openRead();
    final fields = await data
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);
    setState(() {
      this.data = fields;
    });
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _fileType,
        allowMultiple: false,
        allowedExtensions: (extension?.isNotEmpty ?? false)
            ? extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation $e");
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      openFile(_paths![0].path);
      print(_paths);
      print("File path ${_paths![0]}");
      print(_paths!.first.extension);
    });
  }
}
