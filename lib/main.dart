import 'dart:async';
import 'package:books/navigation_first.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'geolocation.dart';
import 'navigation_dialog.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const NavigationDialogScreen(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override 
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the future'),
      ),
      body: Center(
        child: Column(children: [
          const Spacer(),
          ElevatedButton(
            child: const Text('GO!'),
            onPressed: () {
              
                returnError().then((value) {
                setState(() {
                  result = 'Success';
                });
              }).catchError(( onError) {
                setState(() {
                  result = onError.toString();
                });
              }).whenComplete(() => print('Complete'));
            },
          ),
          const Spacer(),
          Text(result),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ]),
        )
    );

   
  }

  late Completer completer;

  Future calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    }
    catch(_) {
      completer.completeError({});
    }
  }
  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }
   Future<Response> getData() async {
      const authority = 'www.googleapis.com';
      const path = '/books/v1/volumes/junbDwAAQBAJ';
      Uri url = Uri.https(authority, path);
      return http.get(url); 
  }
  

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds:  3));
    return 3;

  }

  void returnFG() {
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    futureGroup.future.then((List <int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
       setState(() {
        result = total.toString();
      });


    });
   
  }

  Future count() async {
    int total = 0;
    total += await returnOneAsync();
    total += await returnThreeAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 10));
    throw(Exception('Something terrible happened!'));
  }


  Future handleError() async {
    try {
      await returnError();
    }
    catch (error) {
      setState(() {
        result = error.toString();
      });
    }
    finally {
      print('complete');
    }
  }
}
