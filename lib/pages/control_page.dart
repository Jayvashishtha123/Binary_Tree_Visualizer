import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:binary_tree_visualizer/model/tree_model.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> with TickerProviderStateMixin {
  int _lastTapped = -1; // to track which button is being flashed

  Widget _animatedButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed, {
    required int btnIndex,
  }) {
    final bool blinking = _lastTapped == btnIndex;
    return GestureDetector(
      onTap: () async {
        setState(() => _lastTapped = btnIndex);
        await Future.delayed(const Duration(milliseconds: 120));
        setState(() => _lastTapped = -1);
        await Future.delayed(const Duration(milliseconds: 60));
        onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          boxShadow: [
            if (blinking)
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 16,
                spreadRadius: 1,
              ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton.icon(
          onPressed: null, // disables default splash!
          icon: Icon(icon, color: blinking ? Colors.yellow : Colors.white, size: 24),
          label: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: blinking ? Colors.yellow : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: blinking ? Colors.deepPurpleAccent : Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.white, width: 1.3), // Thin white border
            ),
            elevation: blinking ? 14 : 8,
            shadowColor: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<TreeModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        title: const Text(
          'Controls',
          style: TextStyle(
            
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: Colors.white,
            particleCount: 200,
            //  particleCount: 200,
            spawnMinRadius: 1.0,
            spawnMaxRadius: 3.0,
            spawnMinSpeed: 10.0,
            spawnMaxSpeed: 60.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _animatedButton(context, Icons.add, 'Add Node', model.addNode, btnIndex: 0),
              const SizedBox(height: 20),
              _animatedButton(context, Icons.remove, 'Remove Last', model.removeLast, btnIndex: 1),
              const SizedBox(height: 20),
              _animatedButton(context, Icons.clear_all, 'Clear Tree', model.clear, btnIndex: 2),
              const SizedBox(height: 20),
              _animatedButton(context, Icons.refresh, 'Reset Tree', model.reset, btnIndex: 3),
            ],
          ),
        ),
      ),
    );
  }
}