// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget  build(BuildContext context) {
//     return MaterialApp(
//       title: 'stilos',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.amber,
//         secondaryHeaderColor: Colors.black,
//         hintColor: Colors.green[600],
//       ),
//       home: Home(
//         title: 'Estilos de Aplicativo Flutter',
//       ),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   final String? title;

//   Home({Key? key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title ?? 'Default Title'),
//       ),
//       body: Column(
//         children: [
//           Spacer(),
//           Center(
//             child: Opacity(
//               opacity: .25,
//               child: Text("faded"),
//             ),
//           ),
//           Spacer(),
//           Center(
//             child: Container(
//               color: Theme.of(context).hintColor,
//               child: Text(
//                 "TEXTO COM COR DE FUNDO",
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//             ),
//           ),
//           Spacer(),
//           Center(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF000000),
//                     Color.fromARGB(15, 255, 0, 0),
//                   ],
//                   tileMode: TileMode.mirror,
//                 ),
//               ),
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 child: Text(
//                   "Heloo",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//           Center(
//             child: Container(
//               color: Colors.yellow[600],
//               child: Transform(
//                 alignment: Alignment.bottomLeft,
//                 transform: Matrix4.skewY(0.9)..rotateZ(-6 / 12.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(12.0),
//                   color: Colors.green[600],
//                   child: Text("Eat at Joe's"),
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }
// }
