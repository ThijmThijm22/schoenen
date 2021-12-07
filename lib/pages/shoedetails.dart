import 'dart:ffi';

import 'package:flutter/material.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';
import 'package:schoenen/providers/fireprov.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoeDetails extends StatefulWidget {
  late String imgtag;
  double afstand;
  String naam;
  
  String laatstBewerkt;
  ShoeDetails(
      {Key? key, this.imgtag = "a", this.afstand = 500, this.naam = 'Nike', required this.laatstBewerkt})
      : super(key: key);

  @override
  _ShoeDetailsState createState() => _ShoeDetailsState();
}

class _ShoeDetailsState extends State<ShoeDetails> {
  @override
  Widget build(BuildContext context) {
    var fireProv = Provider.of<FireProv>(context, listen: true);

    TextEditingController kmController = TextEditingController();
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var nowA = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeProv.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SafeArea(
              child: Text(
                widget.naam,
                style: const TextStyle(
                  fontSize: 50,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Deze maan: ${widget.afstand.toString()}km'),
                Text('Dit jaar: ${widget.afstand.toString()}km'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 300, child: NumberInput(controller: kmController)),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(themeProv.btnColor),
                    ),
                    onPressed: () {
                      fireProv.changeShoe(
                          widget.afstand + double.parse(kmController.text),
                          widget.naam);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Toevoegen'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(themeProv.btnColor),
                    ),
                    onPressed: () {
                      fireProv.changeShoe(
                          widget.afstand - double.parse(kmController.text),
                          widget.naam);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Verwijderen'),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 200,
                child: Hero(tag: widget.imgtag, child: themeProv.image)),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NumberInput extends StatelessWidget {
  late TextEditingController controller;
  NumberInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Kilometers',
        focusColor: Color.fromARGB(0, 0, 0, 0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
