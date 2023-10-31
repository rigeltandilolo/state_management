import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:packagebaru/packagebaru.dart';

void main() {
  runApp(MyApp());
}

GlobalState state = GlobalState();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addCounter() {
    setState(() {
      state.addCounter();
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = state.counters.removeAt(oldIndex);
      state.counters.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: ReorderableListView(
        onReorder: _onReorder,
        children: List.generate(
          state.counters.length,
          (index) {
            return CounterWidget(index, () {
              setState(() {});
            }, Key('$index'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCounter,
        tooltip: 'Add Counter',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final int index;
  final Function() callback;
  final Key key;

  CounterWidget(this.index, this.callback, this.key) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late Color cardColor;

  @override
  void initState() {
    super.initState();
    cardColor = _getColorFromIndex(widget.index);
  }

  Color _getColorFromIndex(int index) {
    List<Color> availableColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.brown,
      Colors.yellow,
    ];
    return availableColors[index % availableColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(widget.index),
      color: cardColor,
      child: ListTile(
        title: Text('Counter Value: ${state.counters[widget.index]}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                state.incrementCounter(widget.index);
                widget.callback();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                state.decrementCounter(widget.index);
                widget.callback();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeItem(widget.index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _removeItem(int index) {
    state.removeCounter(index);
    widget.callback();
  }
}
