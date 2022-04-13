import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart' as storage;
import 'data/data.dart';
import 'screens/tasks_screen.dart';

void main() async {
  await storage.GetStorage.init();
  runApp(ChangeNotifierProvider(
    create: (context) => Data(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}
