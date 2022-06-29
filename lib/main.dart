import 'package:flutter/material.dart';

List primes = <int>[];

void genPrimeTable() {
  const int maxValue = 35000;
  List<bool> isPrime = List<bool>.filled(maxValue, true);
  primes.add(2);
  for (var i = 3; i < maxValue; i += 2) {
    if (isPrime[i]) {
      primes.add(i);
      for (var j = i * i; j < maxValue; j += i) {
        isPrime[j] = false;
      }
    }
  }
}

void main() {
  genPrimeTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Factorization',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  
  String inputValue = '';

  String calculate() {
    if (inputValue == '') {
      return '';
    }
    int number = int.parse(inputValue);
    if (number < 1 || number >= 1000000000) {
      return 'Input Error!';
    }
    List<List<int>> factors = [];
    for (int i = 0; i < primes.length; i++) {
      if (primes[i] * primes[i] > number) {
        break;
      }
      while (number % primes[i] == 0) {
        number = number ~/ primes[i];
        if (factors.isEmpty || factors.last[0] != primes[i]) {
          factors.add([primes[i], 1]);
        } else {
          factors.last[1]++;
        }
      }
    }
    if (number != 1 || factors.isEmpty) {
      factors.add([number, 1]);
    }
    String ret = '';
    for (var f in factors) {
      if (ret != '') {
        ret += ' x ';
      } else {
        ret = '= ';
      }
      ret += '${f[0]}^${f[1]}';
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onSubmitted: (value) {
                setState(() {
                  inputValue = value;
                });
              },
              maxLength: 9,
              decoration: const InputDecoration(
                labelText: 'Enter your number',
                hintText: '1~999,999,999',
              ),
              keyboardType: TextInputType.number,
            ),
            Text(calculate())
          ],
        )
      ),
    );
  }
}