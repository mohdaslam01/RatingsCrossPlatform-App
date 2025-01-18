import 'package:flutter/material.dart';
import 'package:ratingsapp/home.dart';
import 'package:ratingsapp/login.dart';
import 'package:ratingsapp/info.dart';
import 'package:ratingsapp/share.dart';

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
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 50, 50, 50)),
        colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 47, 45, 45), // Dark gray
      onPrimary: Color.fromARGB(255, 0, 0, 0), // White text/icons on primary
      secondary: Color.fromARGB(255, 0, 0, 0), // Medium gray
      onSecondary: Color.fromARGB(255, 0, 0, 0), // White text/icons on secondary
      error: Color.fromARGB(255, 0, 0, 0), // Default error color
      onError: Color.fromARGB(255, 0, 0, 0), // White text/icons on background
      surface: Color.fromARGB(255, 0, 0, 0), // Very dark gray for surfaces
      onSurface: Color.fromARGB(255, 0, 0, 0), // White text/icons on surfaces
    ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Color.fromRGBO(28, 53, 239, 1),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ratings ∞'),
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
                  fontFamily: 'Roboto',
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
                  fontFamily: 'Roboto',
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

       