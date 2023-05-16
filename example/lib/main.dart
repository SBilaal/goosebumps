import 'package:goosebumps/goosebumps.dart';
import 'package:flutter/material.dart';

void main() {
  Horror.init(frequency: Frequencies.veryHigh);
  // To be less conspicuous, you can use this instead:
  // WidgetFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goosebumps Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Goosebumps Demo'),
        ),
        body: const Center(
          child: Text(
            'Shake your device to enable/disable the sound!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
