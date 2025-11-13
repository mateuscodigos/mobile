import 'package:lib2/lib/car/CarListModel.dart';
import 'package:lib2/car/CarModel.dart';
import 'package:lib2/conexao.dart/endpoint.dart';
import 'package:flutter/material.dart';

import '../conexao.dart/endpoint.dart';
import 'CarListModel.dart';
import 'CarModel.dart';


class PostCar extends StatefulWidget {
  @override
  _PostCar createState() => _PostCar();
}

class _PostCar extends State{
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CarModel car = new CarModel();
  Future<CarListModel>? carListFuture;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: this._formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (String? inValue){
                this.car.id = int.parse(inValue!);
              },
              decoration: InputDecoration(labelText: "Id")),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (String? inValue){
                if(inValue!.length == 0){
                  return "Por Favor entre com o modelo";
                }
                return null;
              },
              onSaved: (String? inValue){
                this.car.model = inValue!;
              },
              decoration: InputDecoration(labelText: "Model")),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (String? inValue){
                this.car.price = double.parse(inValue!);
              },
              decoration: InputDecoration(labelText:"Price")),
            ElevatedButton(
              child: Text("Save"),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  print("Id: ${car.id}");
                  print("model: ${car.model}");
                  print("price: ${car.price}");
                  callAPI(car);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}