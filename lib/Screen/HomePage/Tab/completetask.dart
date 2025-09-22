import 'package:flutter/material.dart';
import '../../../Database/dbhelper.dart';

class Completetask extends StatefulWidget {
  const Completetask({super.key});

  @override
  State<Completetask> createState() => _CompletetaskState();
}

class _CompletetaskState extends State<Completetask> {
  final DbHelper = MyDb.instance;
  List<Map<String, dynamic>> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: completedTasks.isEmpty
          ? const Center(
        child: Text(
          "No completed tasks available",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: completedTasks.length,
        itemBuilder: (BuildContext context, int index) {
          var data = completedTasks[index];
          return Dismissible(
            key: ValueKey(data["id"]),
            background:  Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
              onDismissed: (direction) async {
                await _deleteTask(data["id"]);
              },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade100, Colors.green.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade200,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    "${data["task_name"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "📝 ${data["task_description"]}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "📅 ${data["task_date"]}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Priority: ${data["task_priority"]}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _loadCompletedTasks() async {
    final allRows = await DbHelper.queryalltask();

    final completed = allRows.where(
          (task) =>
      (task["task_status"]?.toString().toLowerCase() ?? "") ==
          "completed",
    )
        .toList();

    setState(() {
      completedTasks = completed;
    });
  }

  Future<void> _deleteTask(int id) async {
    await DbHelper.deletetask(id);
    _loadCompletedTasks(); // refresh list
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task deleted")),
    );
  }
}
