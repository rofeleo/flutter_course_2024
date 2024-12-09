import 'package:flutter/material.dart';

class EnterCityFiled extends StatefulWidget {
  const EnterCityFiled({super.key});

  @override
  State<StatefulWidget> createState() => _EnterCityFiledState();

}


class _EnterCityFiledState extends State<EnterCityFiled> {
  TextEditingController? _cityController;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            width: 250,
            child: TextField(
              controller: _cityController,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              print(_cityController?.text);
            },
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {},
            child: const Text('Recover password'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cityController?.dispose();
    super.dispose();
  }
}


void main() {
  runApp(const MaterialApp(
    home: MyHomePage(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EnterCityFiled(),
    );
  }
}