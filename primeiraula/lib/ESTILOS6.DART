// import 'package:flutter/material.dart';
// import 'package:primeiraula/widgetcontainer.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Primeira Aula',
//       home: const Home(title: 'Primeira Aula'),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   final String title;
//   const Home({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: GridView.count(
//         crossAxisCount: 10,
//         padding: const EdgeInsets.all(4.0),
//         childAspectRatio: 4.0,
//         mainAxisSpacing: 4.0,
//         crossAxisSpacing: 4.0,
//         scrollDirection: Axis.vertical,
//         children: [
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//           GridTile(child: FlutterLogo()),
//         ],
//       ),
//     );
//   }
// }
