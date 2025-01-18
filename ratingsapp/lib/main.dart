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
                  backgroundColor: Color.fromRGBO(94, 95, 104, 0.097),/*94, 95, 104, 0.097*/
                  foregroundColor: Colors.black,
                ),
                child: const Text('Home'),
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Login Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()), // Added code
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Info Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoPage()), // Added code
                  );
                },
                child: const Text('Info'),
              ),
              const SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Share Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SharePage()), // Added code
                  );
                },
                child: const Text('Share'),
              ),
              ],
            ),      
      ),
      ),
         );
  }
}

       