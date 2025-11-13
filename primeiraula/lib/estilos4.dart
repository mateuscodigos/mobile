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
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           DragTarget<String>(
//             builder: (BuildContext context, List<String?> accepted, List<dynamic> rejected) {
//               return Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//               );
//             },
//             onAccept: (data) {
//               // Use logging in production; print is for demonstration
//               print('Accepted: $data');
//             },
//           ),
//           const SizedBox(height: 50),
//           Draggable<String>(
//             data: 'eu fui arrastado',
//             feedback: Container(
//               width: 100,
//               height: 100,
//               color: Colors.red,
//             ),
//             child: Container(
//               width: 100,
//               height: 100,
//               color:  Colors.yellow,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

