import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({Key? key}) : super(key: key);

  @override 
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.blue.shade700;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog'),
    
      ),
      body: Center(
        child: ElevatedButton(child: const Text('Change Color'),
        onPressed: () {
          _showColorDialog(context);
        },
        ),
      ),
    );
  }


 void _showColorDialog(BuildContext context) async {
  // The showDialog function itself must be awaited, not the builder function.
  Color? selectedColor = await showDialog<Color>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Choose a color'),
        content: const Text('Please choose a color'),
        actions: <Widget>[
          TextButton(
            child: const Text('Red'),
            onPressed: () {
              // Use Navigator.pop to return the selected color.
              Navigator.pop(dialogContext, Colors.red.shade700);
            }),
          TextButton(
            child: const Text('Green'),
            onPressed: () {
              Navigator.pop(dialogContext, Colors.green.shade700);
            }),
          TextButton(
            child: const Text('Blue'),
            onPressed: () {
              Navigator.pop(dialogContext, Colors.blue.shade700);
            }),
        ],
      );
    },
  );

  // Check if a color was selected and if so, update the state with the new color.
  if (selectedColor != null) {
    setState(() {
      color = selectedColor;
    });
  }
}
}