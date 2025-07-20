import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Tree Visualizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Binary Tree Visualizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController(
    text: '1 2 3 4 5 6 7',
  );

  late final Graph graph;
  late final BuchheimWalkerConfiguration builder;

  @override
  void initState() {
    super.initState();
    graph = Graph()..isTree = true;
    builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = 20
      ..levelSeparation = 30
      ..subtreeSeparation = 20
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    _buildTree([1, 2, 3, 4, 5, 6, 7]);
  }

  void _buildTree(List<int> values) {
    graph.nodes.clear();
    graph.edges.clear();
    final Map<int, Node> nodesMap = {};
    for (var v in values) {
      final node = Node.Id(v);
      nodesMap[v] = node;
      graph.addNode(node);
    }
    for (var i = 0; i < values.length; i++) {
      final v = values[i];
      int leftIdx = 2 * i + 1;
      int rightIdx = 2 * i + 2;
      if (leftIdx < values.length) {
        graph.addEdge(nodesMap[v]!, nodesMap[values[leftIdx]]!);
      }
      if (rightIdx < values.length) {
        graph.addEdge(nodesMap[v]!, nodesMap[values[rightIdx]]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter nodes (space-separated)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                final values = text
                    .split(RegExp(r"\s+"))
                    .where((s) => s.isNotEmpty)
                    .map(int.parse)
                    .toList();
                setState(() {
                  _buildTree(values);
                });
              },
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5,
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                builder: (Node node) {
                  final id = node.key!.value as int;
                  return _nodeWidget(id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nodeWidget(int id) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(4),
        color: Colors.lightBlueAccent,
      ),
      child: Text(
        id.toString(),
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
