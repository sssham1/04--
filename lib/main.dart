import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'счетчик',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  
  Future<void> _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
    });
  }

  
  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persistent Counter'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Вы нажали на кнопку:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}