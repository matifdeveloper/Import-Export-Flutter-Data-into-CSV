import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Export extends StatefulWidget {
  const Export({Key? key}) : super(key: key);

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  late List<List<dynamic>> data;

  @override
  void initState() {
    data = List<List<dynamic>>.empty(growable: true);
    for (int i = 0; i < 5; i++) {
      //row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List<dynamic>.empty(growable: true);
      row.add("Name $i");
      row.add((i % 2 == 0) ? "Male" : "Female");
      row.add("Experience $i");
      data.add(row);
    }
    super.initState();
  }

  exportToCSV() async {
    if (await Permission.storage.request().isGranted) {
      //store file in documents folder
      String dir = "${(await getExternalStorageDirectory())!.path}/myCSV.csv";
      File file = File(dir);
      // convert rows to String and write as csv file
      String csv = const ListToCsvConverter().convert(data);
      file.writeAsString(csv);
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export to CSV'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.pink,
                height: 30,
                child: TextButton(
                  onPressed: exportToCSV,
                  child: const Text(
                    "Export to CSV",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
