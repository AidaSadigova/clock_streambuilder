import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isTicking = true;

  Stream<String> getTimeData() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      DateTime now = DateTime.now();
      String time = "${now.hour}:${now.minute}:${now.second}";
      yield time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: const Center(
          child: Text(
            'Current Time',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: isTicking ? getTimeData() : null,
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(90.0),
                width: 220,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.greenAccent[400],
                ),
                child: Center(
                  child: switch (snapshot.connectionState) {
                    ConnectionState.none => const Text('Time stopped',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    ConnectionState.waiting =>
                      const CircularProgressIndicator(),
                    ConnectionState.active => Text(snapshot.data.toString(),
                        style: const TextStyle(
                            fontSize: 40.0, color: Colors.white)),
                    ConnectionState.done => const Text('Done'),
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    isTicking = !isTicking;
                  });
                },
                child: Text(
                  isTicking ? 'Stop' : 'Start',
                  style: const TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
