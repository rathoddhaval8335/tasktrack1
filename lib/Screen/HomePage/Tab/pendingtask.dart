import 'package:flutter/material.dart';
import '../../../Database/dbhelper.dart';

class Pendingtask extends StatefulWidget {
  const Pendingtask({super.key});

  @override
  State<Pendingtask> createState() => _PendingtaskState();
}

class _PendingtaskState extends State<Pendingtask> {
  final DbHelper = MyDb.instance;
  List<Map<String, dynamic>> pendingTask = [];

  @override
  void initState() {
    super.initState();
    _loadPendingTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pendingTask.isEmpty
          ? const Center(
        child: Text(
          "No pending tasks available",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pendingTask.length,
        itemBuilder: (BuildContext context, int index) {
          var data = pendingTask[index];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.pending_actions, // Pending icon
                        color: Colors.orange,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${data["task_name"]}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${data["task_description"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            "${data["task_date"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Priority: ${data["task_priority"]}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _loadPendingTasks() async {
    final allRows = await DbHelper.queryalltask();

    final pending = allRows
        .where(
          (task) =>
      (task["task_status"]?.toString().toLowerCase() ?? "") ==
          "pending",
    )
        .toList();

    setState(() {
      pendingTask = pending;
    });
  }
}
