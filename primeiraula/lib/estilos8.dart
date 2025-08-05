// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:primeiraula/widgetcontainer.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final PageController _controller = PageController(initialPage: 0);
//   int line = -1;
//   final String title = "Pageview";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: PageView(
//         controller: _controller,
//         scrollDirection: Axis.horizontal,
//         children: [
//           list1(
//             WidgetContainer(
//               color: Colors.red,
//               child: const Center(child: Text("1")),
//             ),
//           ),
//           list2(
//             WidgetContainer(
//               color: Colors.green,
//               child: const Center(child: Text("2")),
//             ),
//           ),
//           list3(
//             WidgetContainer(
//               color: Colors.blue,
//               child: const Center(child: Text("3")),
//             ),
//           ),
//           list4(
//             WidgetContainer(
//               color: Colors.yellow,
//               child: const Center(child: Text("4")),
//             ),
//           ),
//           list5(
//             WidgetContainer(
//               color: Colors.purple,
//               child: const Center(child: Text("5")),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
