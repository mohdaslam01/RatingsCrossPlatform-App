
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
          .where((item) =>
              item['item'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search items',
                labelStyle: TextStyle(
                color: Color.fromARGB(255, 55, 0, 255), // Change label text color
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
                    fontSize: 18, // Change font size
                    fontWeight: FontWeight.bold, // Make text bold
                    color: Colors.redAccent, // Change text color
                  ),
                ),
              )
            : Container(
                color: Colors.black12, // Change background color
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Card( // Adds a slight elevation effect
                      color: Colors.white, // Change ListTile background color
                      child: ListTile(
                        title: Text(
                          '${item['professorName']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Make title bold
                            color: Colors.blue, // Change title text color
                          ),
                        ),
                        subtitle: Text(
                          'Course: ${item['classCode']}\nUniversity: ${item['universityCode']}',
                          style: TextStyle(
                            color: Colors.black54, // Change subtitle text color
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

/*import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/