import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Our Mission'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Empowering individuals with accurate data interpretation to foster rational, unbiased decision-making. Our mission is to bridge the gap between information and understanding, ensuring that every choice is informed, equitable, and impactful.\n\n"
              "Importance of Accurate Data Interpretation\n"
              "Informed Decision-Making: Accurate data interpretation allows individuals and organizations to make decisions based on evidence and facts rather than intuition or misinformation. This leads to more rational and effective outcomes.\n\n"
              "Clarity and Transparency: Proper data interpretation helps in presenting clear and transparent information, which is crucial for building trust and credibility. It ensures that the data is understood correctly and used appropriately.\n\n"
              "Identifying Trends and Patterns: By accurately interpreting data, one can identify underlying trends and patterns that might not be immediately obvious. This can help in predicting future outcomes and making proactive decisions.\n\n"
              "Avoiding Bias: Correct data interpretation helps in minimizing biases that can arise from misrepresentation or selective reporting of data. It ensures a more balanced and fair analysis.\n\n"
              "Data Manipulation by News Corporations\n"
              "News corporations sometimes manipulate data to serve specific agendas, which can lead to misinformation and biased public perception. This manipulation can take various forms, such as selective reporting, sensationalism, and misrepresentation of facts.\n\n"
              "Example: COVID-19 Pandemic\n"
              "During the COVID-19 pandemic, there were instances where state actors manipulated news to serve their political goals.",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.cyan), // Setting the text color to aqua
            ),
          ],
        ),
      ),
    );
  }
}
