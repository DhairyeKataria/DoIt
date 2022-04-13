import 'package:do_it/widgets/deleted_tasks_list.dart';
import 'package:do_it/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_it/data/data.dart';
import 'package:do_it/widgets/colored_button.dart';
import 'package:do_it/constants.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  bool _showDeleted = false;

  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).restoreTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            !_showDeleted ? Colors.green.shade200 : Colors.red.shade200,
        child: _showDeleted
            ? Icon(
                Icons.delete,
                color: Colors.red.shade900,
              )
            : Icon(
                Icons.add,
                color: Colors.green.shade900,
              ),
        onPressed: _showDeleted
            ? () {
                Provider.of<Data>(context, listen: false).deleteAllChecked();
              }
            : () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: (context),
                  builder: (context) => const AddTaskScreen(),
                );
              },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.grey.shade400,
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 30.0, left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Do', style: kTitleTextStyle),
                        AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 280),
                          child: const Text('ne', style: kTitleTextStyle),
                        ),
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: _visible ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 280),
                      child: const Text('It', style: kTitleTextStyle),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                  child: Consumer<Data>(
                    builder: (BuildContext context, data, child) => Text(
                      _showDeleted
                          ? data.deletedTaskCount.toString() + " Deleted Tasks"
                          : data.taskCount.toString() + " Tasks",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColoredButton(
                      text: 'Current',
                      color: Colors.green,
                      elevate: !_showDeleted,
                      onTap: () {
                        setState(() {
                          _visible = false;
                          _showDeleted = false;
                        });
                      },
                    ),
                    ColoredButton(
                      text: 'Deleted',
                      color: Colors.red,
                      elevate: _showDeleted,
                      onTap: () {
                        setState(() {
                          _visible = true;
                          _showDeleted = true;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child:
                  _showDeleted ? const DeletedTasksList() : const TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
