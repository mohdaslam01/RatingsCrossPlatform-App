import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> allItems = [];
  List<Map<String, dynamic>> filteredItems = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAllItems();
  }

  Future<void> _fetchAllItems() async {
    try {
      final querySnapshot = await db.collection("users").get();
      List<Map<String, dynamic>> fetchedItems = [];
      for (var doc in querySnapshot.docs) {
        if (doc.data()['items'] != null) {
          List<dynamic> userItems = doc.data()['items'];
          fetchedItems.addAll(userItems.cast<Map<String, dynamic>>());
        }
      }
      setState(() {
        allItems = fetchedItems;
        filteredItems = fetchedItems;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching items: $e');
    }
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) => item['professorName']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleYes(int index) {
    // Handle the "Yes" button press for the item at the given index
    print('Yes pressed for item $index');
  }

  void _handleNo(int index) {
    // Handle the "No" button press for the item at the given index
    print('No pressed for item $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('∞ Unlimited'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
              controller: searchController,
              onChanged: _filterItems,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search items',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 55, 0, 255),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'No items found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                : Container(
                    color: Colors.black12,
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Card(
                          color: const Color.fromARGB(103, 76, 75, 75),
                          child: ListTile(
                            title: Text(
                              '${item['professorName']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            subtitle: Text(
                              'Course: ${item['classCode']}\nUniversity: ${item['universityCode']}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 68, 255),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check, color: Color.fromARGB(255, 0, 255, 8)),
                                  onPressed: () => _handleYes(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Color.fromARGB(255, 255, 17, 0)),
                                  onPressed: () => _handleNo(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
