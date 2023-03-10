import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/new_post.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final routes = {
    HomePage.routeName: (context) => const HomePage(),
    NewPost.routeName: (context) => const NewPost(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
