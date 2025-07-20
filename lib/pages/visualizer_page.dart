import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';
import 'package:provider/provider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:binary_tree_visualizer/model/tree_model.dart';

class VisualizerPage extends StatefulWidget {
  const VisualizerPage({super.key});
  @override
  State<VisualizerPage> createState() => _VisualizerPageState();
}

class _VisualizerPageState extends State<VisualizerPage>
    with TickerProviderStateMixin {
  late Graph graph;
  late BuchheimWalkerConfiguration builder;

  @override
  void initState() {
    super.initState();
    graph = Graph()..isTree = true;
    builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = 30
      ..levelSeparation = 50
      ..subtreeSeparation = 30
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  void _rebuildGraph(List<int> values) {
    graph.nodes.clear();
    graph.edges.clear();
    final nodeMap = <int, Node>{};
    for (var v in values) {
      nodeMap[v] = Node.Id(v);
      graph.addNode(nodeMap[v]!);
    }
    for (var i = 0; i < values.length; i++) {
      final v = values[i];
      final left = 2 * i + 1, right = 2 * i + 2;
      if (left < values.length) {
        graph.addEdge(nodeMap[v]!, nodeMap[values[left]]!,
            paint: Paint()
              ..color = Colors.white
              ..strokeWidth = 3.0);
      }
      if (right < values.length) {
        graph.addEdge(nodeMap[v]!, nodeMap[values[right]]!,
            paint: Paint()
              ..color = Colors.white
              ..strokeWidth = 3.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final values = context.watch<TreeModel>().values;

    if (values.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('Binary Tree Visualizer',style: TextStyle(color: Colors.white)),backgroundColor: Colors.black,),
        body: const Center(child: Text('🚫 Tree is empty', style: TextStyle(color: Colors.white))),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<TreeModel>().reset(),
          child: const Icon(Icons.refresh),
        ),
      );
    }

    _rebuildGraph(values);

    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
  centerTitle: true,
  backgroundColor: Colors.black87,
  title: const Text(
    'Binary Tree Visualizer',
    style: TextStyle(
      color: Colors.white, // Always white, visible on black bg
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 1.2,
    ),
  ),
),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options:  ParticleOptions(
            baseColor: Colors.white,      // white stars
            // spawnMinOpacity: 0.2,
            // spawnMaxOpacity: 0.7,
            particleCount: 200,
            spawnMinRadius: 1.0,
            spawnMaxRadius: 3.0,
            spawnMinSpeed: 10.0,
            spawnMaxSpeed: 60.0,
            // For more color, use paintColorRandom with a color palette.
          ),
        ),
        child: SizedBox.expand(
  child: Center(
    child: InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(100),
      minScale: 0.2,
      maxScale: 5,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        builder: (Node node) {
          final id = node.key!.value as int;
          final color = HSVColor.fromAHSV(
            1.0,
            (id * 40) % 360,
            0.7,
            1.0,
          ).toColor();
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.5, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(opacity: scale, child: child),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Text(
                id.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    ),
  ),
),
          
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => context.read<TreeModel>().shuffle(),
        tooltip: 'Shuffle nodes',
        child: const Icon(Icons.shuffle, color: Colors.white),
      ),
    );
  }
}