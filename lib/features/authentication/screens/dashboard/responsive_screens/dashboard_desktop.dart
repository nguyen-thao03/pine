import 'package:flutter/material.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Table(
          children: const [
            TableRow(
              children: [
                TableCell(child: Text('Cell 1')),
                TableCell(child: Text('Cell 2')),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('Cell 3')),
                TableCell(child: Text('Cell 4')),
              ],
            ),
          ],
        )
      ),
    );
  }
}
