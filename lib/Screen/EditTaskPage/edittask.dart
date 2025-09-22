import 'package:flutter/material.dart';
import '../../Database/dbhelper.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final DbHelper = MyDb.instance;
  List<Map<String, dynamic>> allTaskData = [];

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Tasks"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: allTaskData.isEmpty
          ? const Center(
        child: Text(
          "No tasks available",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: allTaskData.length,
        itemBuilder: (BuildContext context, int index) {
          var data = allTaskData[index];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                "${data["task_name"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data["task_description"]}"),
                  const SizedBox(height: 5),
                  Text("Date: ${data["task_date"]}"),
                  Text("Priority: ${data["task_priority"]}"),
                  Text("Status: ${data["task_status"]}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.deepPurple),
                onPressed: () {
                  _showEditDialog(data);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _query() async {
    final allRows = await DbHelper.queryalltask();
    setState(() {
      allTaskData = allRows;
    });
  }

  void _showEditDialog(Map<String, dynamic> data) {
    TextEditingController titleController =
    TextEditingController(text: data["task_name"]);
    TextEditingController descController =
    TextEditingController(text: data["task_description"]);
    TextEditingController dateController =
    TextEditingController(text: data["task_date"]);
    TextEditingController priorityController =
    TextEditingController(text: data["task_priority"]);

    bool isCompleted = data["task_status"] == "completed";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Date"),
                ),
                TextField(
                  controller: priorityController,
                  decoration: const InputDecoration(labelText: "Priority"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isCompleted,
                      onChanged: (val) {
                        setState(() {
                          isCompleted = val!;
                        });
                        Navigator.pop(context); // close old dialog
                        _showEditDialog({
                          "id": data["id"],
                          "task_name": titleController.text,
                          "task_description": descController.text,
                          "task_date": dateController.text,
                          "task_priority": priorityController.text,
                          "task_status": isCompleted ? "completed" : "pending",
                        });
                      },
                    ),
                    const Text("Mark as complete"),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Map<String, dynamic> updatedRow = {
                  "task_name": titleController.text,
                  "task_description": descController.text,
                  "task_date": dateController.text,
                  "task_priority": priorityController.text,
                  "task_status": isCompleted ? "completed" : "pending",
                };

                await DbHelper.UpdateTask(updatedRow, data["id"]);
                Navigator.pop(context);
                _query();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
