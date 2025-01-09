import 'package:finalnewsapiproject/pages/everything.dart';
import 'package:finalnewsapiproject/pages/home.dart';
import 'package:finalnewsapiproject/pages/welcomepage.dart';
import 'package:finalnewsapiproject/providers/everything_provider.dart';
import 'package:finalnewsapiproject/providers/headline_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HeadlineProvider()),
    ChangeNotifierProvider(create: (_) => EverythingProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var currentIndex = 0;

  var bodies = const [
    Home(),
    EverythingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment), label: "Everything"),
        ],
      ),
    );
  }
}
