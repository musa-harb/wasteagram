import 'package:flutter/material.dart';
import 'screens/homepage.dart';


class App extends StatelessWidget {
  const App({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),      
      home: const HomePage(),
    );
  }
}