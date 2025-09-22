import 'package:flutter/material.dart';

import 'Tab/alltask.dart';
import 'Tab/completetask.dart';
import 'Tab/pendingtask.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Title color
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          tabs: const [
            Tab(
              icon: Icon(Icons.list_alt, color: Colors.white),
              text: "All",
            ),
            Tab(
              icon: Icon(Icons.check_circle, color: Colors.white),
              text: "Complete",
            ),
            Tab(
              icon: Icon(Icons.pending_actions, color: Colors.white),
              text: "Pending",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Alltask(),
          Completetask(),
          Pendingtask(),
        ],
      ),
    );
  }

}
