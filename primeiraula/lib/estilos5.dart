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
//         children: [
//           Container(height: 100),
//           DataTable(
//             sortColumnIndex: 1,
//             columns: const [
//               DataColumn(label: Text("primeiro nome")),
//               DataColumn(label: Text("segundo nome")),
//               DataColumn(label: Text("ultimo nome")),
//             ],
//             rows: const [
//               DataRow(cells: [
//                 DataCell(Text("leia")),
//                 DataCell(Text("organa")),
                
//               ]),
//               DataRow(cells: [
//                 DataCell(Text("luke")),
//                 DataCell(Text("Skywalker")),
                
//               ]),
//               DataRow(cells: [
//                 DataCell(Text("Han")),
//                 DataCell(Text("Solo")),
               
//               ]),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
