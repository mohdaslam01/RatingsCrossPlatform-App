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
        var userItems = List<Map<String, dynamic>>.from(doc.data()['items'] ?? []);
        userItems.forEach((item) {
          item['docId'] = doc.id; // Store document ID for reference
          fetchedItems.add(item);
        });
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
          .where((item) =>
              item['professorName'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _handleVote(int index, bool isYesVote) async {
    final item = filteredItems[index];
    final docId = item['docId']; // Retrieve the document ID
    final userDoc = await db.collection("users").doc(docId).get();
    if (userDoc.exists) {
      List<dynamic> items = List<dynamic>.from(userDoc.data()?['items'] ?? []);
      int itemIndex = items.indexWhere((i) =>
          i['professorName'] == item['professorName'] &&
          i['classCode'] == item['classCode']);
      if (itemIndex != -1) {
        items[itemIndex][isYesVote ? 'yesCount' : 'noCount']++;
        await db.collection("users").doc(docId).update({'items': items});
        setState(() {
          filteredItems[index][isYesVote ? 'yesCount' : 'noCount'] = items[itemIndex][isYesVote ? 'yesCount' : 'noCount'];
        });
      }
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
              controller: searchController,
              onChanged: _filterItems,
              style: TextStyle(color: const Color.fromARGB(255, 255, 17, 0)),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search items',
                labelStyle: TextStyle(color: Color.fromARGB(255, 55, 0, 255)),
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
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: const Color.fromARGB(103, 76, 75, 75),
                        child: ListTile(
                          title: Text(
                            item['professorName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            'Course: ${item['classCode']}\nUniversity: ${item['universityCode']}',
                            style: const TextStyle(color: Color.fromARGB(255, 0, 68, 255)),
                          ),
                          trailing: _buildTrailingColumn(item, index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingColumn(Map<String, dynamic> item, int index) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
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
                  onPressed: () => _handleVote(index, true),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color.fromARGB(255, 255, 0, 0)),
                  onPressed: () => _handleVote(index, false),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item['yesCount']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 89, 255, 0),
                  ),
                ),
                const SizedBox(width: 40),
                Text(
                  '${item['noCount']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
