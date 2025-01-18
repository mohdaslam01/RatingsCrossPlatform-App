import 'package:flutter/material.dart';
import 'package:ratingsapp/home.dart';
import 'home.dart';
import 'login.dart';
import 'info.dart';
import 'share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratings App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ratings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/black.png'),
              fit: BoxFit.cover, 
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                onPressed: () {
                  // Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()), // Added code
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(138, 138, 145, 0.788),/*94, 95, 104, 0.097*/
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  )
                ),
                child: const Text('Home',
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 18,
                )
                )
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()), // Added code
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(112, 112, 119, 0.792),/*94, 95, 104, 0.097*/
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  )
                ),
                child: const Text('Login',
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 18,
                )
                )
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoPage()), // Added code
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(138, 138, 145, 0.788),/*94, 95, 104, 0.097*/
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  )
                ),
                child: const Text('About',
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 18,
                )
                )
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SharePage()), // Added code
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(112, 112, 119, 0.792),/*94, 95, 104, 0.097*/
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  )
                ),
                child: const Text('Share',
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 18,
                )
                )
              ),
              ],
            ),      
      ),
      ),
         );
  }
}

       