import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Birthday',
      home: MyCustomForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class PresentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s focus'),
        backgroundColor: Colors.purple[300],
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/glitter.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Image(image: AssetImage(
              'assets/images/QR_last.png')),
        ),
      ),
    );
  }
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi Kristina"),
        backgroundColor: Colors.purple[300],
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/clouds.jpeg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [SizedBox(width: 300, height: 40, child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white,
                        style: BorderStyle.solid,
                        width: 10)
                ),
                filled: true,
                fillColor: Colors.lightBlue[100],
                labelText: "put your guess",
                labelStyle: TextStyle(color: Colors.purple, fontSize: 26),
                hoverColor: Colors.lightBlue[100],
                floatingLabelStyle: TextStyle(color: Colors.purpleAccent, fontSize: 15),
                //icon: Icon(Icons.satellite_alt)
              ),
              onSubmitted: (value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    if (value == "95321246812357") {
                      AudioPlayer().play(AssetSource('audio/happy-birthday-jazz.mp3'));
                      return AlertDialog(
                        // Retrieve the text the that user has entered by using the
                        // TextEditingController.
                        title: Text('Happy birthday'),
                        content: Image(
                          image: AssetImage('assets/images/fireworks_funny.webp'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: ()
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:
                                    (context) => PresentPage()
                                ),
                              );

                            },
                            child: const Text('you are close..'),
                          ),
                        ],
                      );
                    }
                    else {
                      return AlertDialog(
                        title: Text('Try again..'),
                        // Retrieve the text the that user has entered by using the
                        // TextEditingController.
                        content: Image(
                            image: AssetImage('assets/images/oh-no-nooo.gif')
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Again'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Search the answer in the code'),
                            onPressed: _launchURL,
                          ),
                        ],
                      );
                    }
                  },
                );
              },
            ))],
          ),
        ),
      ),
      backgroundColor: Colors.lime[200],
    );
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://github.com/tonyako/birthday_quiz');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}