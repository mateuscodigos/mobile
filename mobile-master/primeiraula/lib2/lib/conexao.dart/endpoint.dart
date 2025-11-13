import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fluflua/car/CarListModel.dart';
import 'package:fluflua/car/CarModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _noValueGiven = "";

String pokes = "https://pokeapi.co/api/v2/pokemon/";
String carGet = "https://localhost/intimobiel/list.php";
String carPost = "https://localhost/intimobiel/store.php";

Future<CarListModel> getCarListData([String id = _noValueGiven]) async {
  await Future.delayed(const Duration(seconds: 2));
  var response;
  if (identical(id, _noValueGiven)) {
    response = await http.get(
      Uri.parse(carGet),
    );
  } else {
    response = await http.get(
      Uri.parse(carGet).replace(queryParameters: {"id": id}),
    );
  }
  return CarListModel.fromJson(jsonDecode(response.body));
}

Future<http.Response> createPost(CarModel car, String Url) async {
  print("asdf" + jsonEncode(car));
  final response = await http.post(Uri.parse(carPost),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:''
    },
    body: jsonEncode(car),);

  print("321" + jsonEncode(car));
  return response;
}

CarListModel postFromJson(String str) {
  final jsonData = json.decode(str);
  return CarListModel.fromJson(jsonData);
}

Future<CarListModel> callAPI(CarModel car) async{
  print(car.toJson());
  createPost(car, carPost).then((response) {
    if (response.statusCode == 200) {
      print("1" + response.body);
      return CarListModel.fromJson(json.decode(response.body));
    } else {
      print("2" + response.statusCode.toString());
      return response.statusCode.toString();
    }
  }).catchError((error){
    print("errors : $error");
    return error.toString();
  });
  throw "Erro1";
}

Future<bool> isConnected() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile){
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi){
    return true;
  }
  return false;
}

Widget loadingView(){
  return Center(  
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
Widget noDataView(String msg) => Center(
  child: Text(
    msg,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    ),
  );