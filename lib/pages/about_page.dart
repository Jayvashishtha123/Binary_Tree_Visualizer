import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_tree_rounded, size: 64, color: Colors.deepPurpleAccent),
              const SizedBox(height: 24),
              const Text(
                'Binary Tree Visualizer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'A fun, interactive tool for visualizing and manipulating binary trees.\n'
                '• Built with Flutter, GraphView, and Animated Background.\n'
                '• Visualize, pan, and zoom the tree.\n'
                '• Use Controls to mutate and reset the tree.\n'
                '• Beautiful animated \"galaxy\" background.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white70),
              ),
              const SizedBox(height: 28),
              const Text(
                'Created by Jay Vardhan Vashishtha',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Instagram',
                    icon: const Icon(Icons.camera_alt_rounded, color: Colors.pink, size: 32),
                    onPressed: () => _launchUrl('https://www.instagram.com/jay.v.vashishtha/'),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    tooltip: 'LinkedIn',
                    icon: const Icon(Icons.business, color: Colors.blueAccent, size: 32),
                    onPressed: () => _launchUrl('https://www.linkedin.com/in/jay-vardhan-vashishtha-6aa069250/'),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    tooltip: 'GitHub',
                    icon: const Icon(Icons.code, color: Colors.white, size: 32),
                    onPressed: () => _launchUrl('https://github.com/Jayvashishtha123'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Connect with me on social media!',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}