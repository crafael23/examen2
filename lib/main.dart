import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'api_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Claudio Vasquez - Examen'),
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
  final TextEditingController textFieldTextController = TextEditingController();

  late ApiResponse respuesta = ApiResponse();

  String text = '';

  void onPressed() {
    print(textFieldTextController.text);

    if (textFieldTextController.text.endsWith('?')) {
      text = textFieldTextController.text;

      final provider = ApiResponseProvider();

      provider.getAnswer().then((value) {
        respuesta = value;
      });
    } else {
      textFieldTextController.clear();
      return;
    }

    textFieldTextController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            child: Center(
              child: Text(),
            ),
          ),
          Text(text),
          TextFieldWidgetCustom(
              onPressed: onPressed,
              textFieldTextController: textFieldTextController),
        ],
      ),
    );
  }
}

class TextFieldWidgetCustom extends StatefulWidget {
  const TextFieldWidgetCustom({
    super.key,
    required this.textFieldTextController,
    required this.onPressed,
  });

  final void Function() onPressed;

  final TextEditingController textFieldTextController;

  @override
  State<TextFieldWidgetCustom> createState() => _TextFieldWidgetCustomState();
}

class _TextFieldWidgetCustomState extends State<TextFieldWidgetCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.textFieldTextController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
                onPressed: widget.onPressed, icon: const Icon(Icons.send))),
      ),
    );
  }
}
