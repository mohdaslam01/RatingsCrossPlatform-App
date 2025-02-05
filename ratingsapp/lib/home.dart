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
          for (var item in userItems) {
            fetchedItems.add({
              'id': item['id'], // Ensure each item has a unique identifier
              'professorName': item['professorName'],
              'classCode': item['classCode'],
              'universityCode': item['universityCode'],
              'yesCount': item['yesCount'] ?? 0,
              'noCount': item['noCount'] ?? 0,
            });
          }
        }
      }
      setState(() {
        allItems = fetchedItems;
        filteredItems = fetchedItems;
      });
    } catch (e) {
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

  void _handleYes(int index) async {
    final item = filteredItems[index];
    final newYesCount = item['yesCount'] + 1;

    // Update the local state
    setState(() {
      filteredItems[index]['yesCount'] = newYesCount;
    });

    // Update Firestore
    try {
      await db.collection("users").doc(item['id']).update({
        'yesCount': newYesCount,
      });
    } catch (e) {
      print('Error updating yesCount: $e');
    }
  }

  void _handleNo(int index) async {
    final item = filteredItems[index];
    final newNoCount = item['noCount'] + 1;

    // Update the local state
    setState(() {
      filteredItems[index]['noCount'] = newNoCount;
    });

    // Update Firestore
    try {
      await db.collection("users").doc(item['id']).update({
        'noCount': newNoCount,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error updating noCount: $e');
    }
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
                            trailing: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(8.0), // Adds padding inside the container
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 0, 0), // Background color
                                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26, // Soft shadow effect
                                      blurRadius: 4.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.check, color: Color.fromARGB(255, 0, 255, 8)),
                                          onPressed: () => _handleYes(index),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close, color: Color.fromARGB(255, 255, 0, 0)),
                                          onPressed: () => _handleNo(index),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${item['yesCount']}',
                                          style: const TextStyle(
                                            fontSize: 12, // Increased font size
                                            fontWeight: FontWeight.bold, // Bold text
                                            color: Color.fromARGB(255, 89, 255, 0), // Text color
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        Text(
                                          '${item['noCount']}',
                                          style: const TextStyle(
                                            fontSize: 12, // Increased font size
                                            fontWeight: FontWeight.bold, // Bold text
                                            color: Color.fromARGB(255, 255, 0, 0), // Text color
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
