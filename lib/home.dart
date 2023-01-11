import 'package:flutter/material.dart';
import 'package:import_export/import.dart';

import 'export.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Export Data'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Export(),
                  ),
                );
              },
              child: const Text('Export'),
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Import(),
                  ),
                );
              },
              child: const Text('Import'),
            ),
          ],
        ),
      ),
    );
  }
}