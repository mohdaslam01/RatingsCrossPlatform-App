import 'package:flutter/material.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the aqua color
    const Color aquaColor = Color.fromARGB(255, 255, 36, 36);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Share'),
      ),
      body: Center(
        child: Text(
          'Share with Your Classmates ',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: aquaColor,
          ),
        ),
      ),
    );
  }
}
