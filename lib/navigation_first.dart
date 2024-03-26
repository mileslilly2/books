import 'package:flutter/material.dart';
import 'navigation_second.dart';

class NavigationFirst extends StatefulWidget {
  @override
  _NavigationFirstState createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation First'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Change Color'),

        onPressed: () {
          _navigateAndGetColor(context);
        },
      ),
    ));
  }

Future<void> _navigateAndGetColor(BuildContext context) async {
      color = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationSecond()),
      ) ?? Colors.blue;
      setState(() {});
    }
}




