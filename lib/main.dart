import 'package:flutter/material.dart';
import 'package:binary_tree_visualizer/model/tree_model.dart';
import 'package:binary_tree_visualizer/pages/visualizer_page.dart';
import 'package:binary_tree_visualizer/pages/control_page.dart';
import 'package:binary_tree_visualizer/pages/about_page.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TreeModel(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Tree Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    VisualizerPage(),
    ControlPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.black,
  currentIndex: _currentIndex,
  selectedLabelStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  unselectedLabelStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white,
  onTap: (i) => setState(() => _currentIndex = i),
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.account_tree, color: Colors.white),
      label: 'Visualizer',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings, color: Colors.white),
      label: 'Controls',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info, color: Colors.white),
      label: 'About',
    ),
  ],
),
    );
  }
}