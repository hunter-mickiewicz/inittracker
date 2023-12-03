import 'init_order.dart';
import 'FileIO.dart';
import 'package:flutter/material.dart';
import 'package:init_tracker/main.dart';

class DataOperations extends StatefulWidget {
  const DataOperations({super.key});

  @override
  State<DataOperations> createState() => _DataOperationsState();
}

class _DataOperationsState extends State<DataOperations> {
  Future<void> newInitOrder() async {
    combMan?.combatants?.clear();
    await showDialog(
        context: context,
        builder: (BuildContext context) => NewInitOrder(combMan: combMan));
    setState(() {});
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold();
  }
}
