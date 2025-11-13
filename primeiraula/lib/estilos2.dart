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
//         body: const MyStatefulWidget(),
//       ),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   MyStatefulWidgetState createState() => MyStatefulWidgetState();
// }

// class MyStatefulWidgetState extends State<MyStatefulWidget> {
//   var _color = Colors.red;
//   var _fontSize = 20.0;
//   var _state = 0;

//   void _mudarEstado() {
//     setState(() {
//       if (_state == 0) {
//         _color = Colors.blue;
//         _fontSize = 40.0;
//         _state = 1;
//       } else if (_state == 1) {
//         _color = Colors.green;
//         _fontSize = 28.0;
//         _state = 2;
//       } else {
//         _color = Colors.red;
//         _fontSize = 20.0;
//         _state = 0;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: _mudarEstado,
//           child: Center(
//             child: AnimatedDefaultTextStyle(
//               duration: const Duration(seconds: 2),
//               style: TextStyle(color: _color, fontSize: _fontSize),
//               child: const Text("Texto animado"),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
