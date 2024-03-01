import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PO"),
      ),
      body:  const Center(
        child: Column(
          children: [
            Text("data")
          ],
        ),
      )
    );
  }
}

//esto debe ir dentr de un button
//conext.router.push(DetailsRoute()),
