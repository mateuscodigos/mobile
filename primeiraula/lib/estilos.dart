// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   static const String title = 'Estilos de Aplicativo Flutter';

//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'stilos',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(title),
//         ),
//             body: Column(
//               children: [
//                 Container(height: 100),
//                 Table(
//                   border: const TableBorder(
//                     top: BorderSide(width: 10.0),
//                     bottom: BorderSide(width: 10.0),
//                     left: BorderSide(width: 10.0),
//                     right: BorderSide(width: 10.0),
//                   ),
//                   children: const [
//                     TableRow(children: [
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("1"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("2"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("3"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("2"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("3"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("2"))),
//                       Center(child: Padding(padding: EdgeInsets.all(10), child: Text("3"))),
          
//                     ])

//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     }