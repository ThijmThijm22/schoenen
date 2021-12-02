import 'package:flutter/material.dart';


// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';

class NewShoe extends StatefulWidget {
  const NewShoe({Key? key}) : super(key: key);

  @override
  _NewShoeState createState() => _NewShoeState();
}

class _NewShoeState extends State<NewShoe> {
  TextEditingController naamController = TextEditingController();
  TextEditingController afstandController = TextEditingController();

  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return Scaffold(
      
      backgroundColor: themeProv.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SafeArea(
                child: Center(
              child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      NewInput(
                        controller: naamController,
                      ),
                      const SizedBox(height: 20),
                      NumberInput(
                        controller: afstandController,
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(themeProv.btnColor),
                          ),
                          onPressed: () {
                            var inst = FirebaseFirestore.instance;
                            var userId = FirebaseAuth.instance.currentUser;
                            if (naamController.text != "" &&
                                afstandController.text != "") {
                              var collectie = inst.collection(userId!.uid);
                              inst
                                  .collection(userId.uid)
                                  .add({
                                    "naam": naamController.text,
                                    "afstand": afstandController.text,
                                    }
                                  )
                                  .catchError((err) => print(err))
                                  .then((value) =>
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/home',
                                          (Route<dynamic> route) => false));
                            }
                          },
                          child: const Text('Schoen Toevoegen'),
                        ),
                      ),
                    ],
                  )),
            )),
            SizedBox(width: 200, child: themeProv.image),
          ],
        ),
      ),
    );
  }
}

class NewInput extends StatelessWidget {
  late TextEditingController controller;
  NewInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Naam Van Schoen',
        focusColor: Color.fromARGB(0, 0, 0, 0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0),
        ),
      ),
    );
  }
}

class NumberInput extends StatelessWidget {
  late TextEditingController controller;
  NumberInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Aantal Kilometers',
        focusColor: Color.fromARGB(0, 0, 0, 0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
