import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// ignore: unused_import
import 'package:ratingsapp/home.dart';
// ignore: unused_import
import 'package:ratingsapp/main.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? _user;
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> allItems = []; // Holds all users' items for search functionality

  final TextEditingController itemController = TextEditingController();
  //final TextEditingController phoneController = TextEditingController();
  //final TextEditingController communicationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController professorNameController = TextEditingController();
  final TextEditingController classCodeController = TextEditingController();
  //final TextEditingController professorEducationController = TextEditingController();
  //final TextEditingController professorAgeController = TextEditingController();
  //final TextEditingController professorMeetingController = TextEditingController();
  //final TextEditingController professorNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
        if (_user != null) {
          _fetchUserItems();
          _fetchAllItems(); // Fetch all items for viewing/search
        }
      });
    });
  }

  Future<void> _addOrUpdateUserInFirestore() async {
    if (_user == null) return;
    try {
      await db.collection("users").doc(_user!.uid).set({
        "email": _user!.email,
      }, SetOptions(merge: true));
      // ignore: avoid_print
      print('User data added/updated successfully!');
    } catch (e) {
      // ignore: avoid_print
      print('Error adding/updating user: $e');
    }
  }

  Future<void> _fetchUserItems() async {
    if (_user == null) return;
    try {
      final doc = await db.collection("users").doc(_user!.uid).get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          items = List<Map<String, dynamic>>.from(doc.data()?['items'] ?? []);
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user items: $e');
    }
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
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching all items: $e');
    }
  }

  Future<void> _addItem(String item, String professorName, String classCode, int yesCount, int noCount/*, String communicationType, String professorName, String className, 
  String professorEducation, String professorAge, String professorMeeting, String professorNotes,*/) async {
    if (_user == null) return;
    try {
      final newItem = {
        "universityCode": item,
        "professorName": professorName,
        "classCode": classCode,
        "yesCount" : yesCount,
        "noCount" : noCount,
      };
      setState(() {
        items.add(newItem);
      });
      await db.collection("users").doc(_user!.uid).set(
        {'items': items},
        SetOptions(merge: true),
      );
      _fetchAllItems(); // Refresh all items
    } catch (e) {
      // ignore: avoid_print
      print('Error adding item: $e');
    }
  }

  void _filterAllItems(String query) {
    setState(() {
      allItems = allItems.where((item) {
        return item['item']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professor details as'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog();
            },
          ),
        ],
      ),
      body: _user != null ? _crudUI() : _googleSignInButton(),
    );
  }

  Widget _crudUI() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: itemController,
            inputFormatters: [
          UpperCaseTextFormatter(), // Enforces uppercase input
          LengthLimitingTextInputFormatter(4), // Limits input to 5 characters
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),//Only characters as Input - Input REstriction. 
        ],
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 0, 0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 0.788),
              ),
              decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Border color when focused
            ),
              border: OutlineInputBorder(),
              labelText: 'University',
              labelStyle: TextStyle(color: Color.fromRGBO(255, 72, 72, 1))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: professorNameController,
            inputFormatters: [
          UpperCaseTextFormatter(), // Enforces uppercase input
          LengthLimitingTextInputFormatter(26), // Limits input to 5 characters
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),//Only characters as Input - Input REstriction. 
        ],
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 0, 170),
              backgroundColor: Color.fromRGBO(22, 22, 22, 0.788),
              ),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Border color when focused
            ),
              border: OutlineInputBorder(),
              labelText: 'Professor Name',
              labelStyle: TextStyle(color: Color.fromRGBO(234, 72, 255, 1))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: classCodeController,
            inputFormatters: [
          UpperCaseTextFormatter(), // Enforces uppercase input
          LengthLimitingTextInputFormatter(8), // Limits input to 5 characters
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),//Only characters as Input - Input REstriction. 
        ],
            style: const TextStyle(
              color: Color.fromARGB(255, 170, 255, 0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 0.788),
              ),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Border color when focused
            ),
              border: OutlineInputBorder(),
              labelText: 'Class Code',
              labelStyle: TextStyle(color: Color.fromRGBO(188, 255, 72, 1))
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (itemController.text.isNotEmpty &&
                professorNameController.text.isNotEmpty &&
                classCodeController.text.isNotEmpty/* && 
                professorNameController.text.isNotEmpty && 
                classCodeController.text.isNotEmpty && 
                professorEducationController.text.isNotEmpty && 
                professorAgeController.text.isNotEmpty && 
                professorMeetingController.text.isNotEmpty && 
                professorNotesController.text.isNotEmpty*/) {
              _addItem(itemController.text.toUpperCase(), professorNameController.text,
                  classCodeController.text, 0, 0 /*professorNameController.text, 
                  classCodeController.text, professorEducationController.text, 
                  professorAgeController.text, professorMeetingController.text,
                  professorNotesController.text -- Future refeence*/);
              itemController.clear();
              professorNameController.clear();
              classCodeController.clear();
              /*professorNameController.clear();
              classCodeController.clear();
              professorEducationController.clear();
              professorAgeController.clear();
              professorMeetingController.clear();
              professorNotesController.clear();*/
            }
          },
          child: const Text('Add details', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 68, 255)),),
        ),
      ],
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 40,
        child: SignInButton(
          Buttons.Google,
          text: "Google Sign up",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(googleAuthProvider);
      await _auth.currentUser?.reload();
      setState(() {
        _user = _auth.currentUser;
      });
      if (_user != null) {
        _addOrUpdateUserInFirestore();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error signing in: $e');
    }
  }

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Items'),
          content: TextField(
            controller: searchController,
            onChanged: _filterAllItems,
            decoration: const InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}//Below is login code for successfully - above is the code with DB connection access succesffully. 
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// ignore: unused_import
import 'package:ratingsapp/home.dart';
import 'package:ratingsapp/main.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event){
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Customize as needed
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }
  Widget _googleSignInButton(){
    return Center(child: SizedBox(
      height: 50, 
      child: SignInButton(Buttons.Google, text: "Sign up with Google", onPressed: _handleGoogleSignIn/*(){}*/),));
  }
  Widget _userInfo(){
    return SizedBox(child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
      child: Text('Go to HomePage'),
    ),);
  }
  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    }
    catch(error){
      // ignore: avoid_print
      print(error);
    }
  }
}

/*import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Customize as needed
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Return to the previous page
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color
            foregroundColor: Colors.white, // Button text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
          ),
          child: const Text(
            'Return to Main',
            style: TextStyle(fontSize: 16), // Customize text size
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/*/