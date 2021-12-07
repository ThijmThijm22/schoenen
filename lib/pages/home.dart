import 'package:flutter/material.dart';

// Packages
import 'package:intl/intl.dart';

// Services
import 'package:schoenen/services/globals.dart';

// Widgets
import 'package:schoenen/widgets/shoecard.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';
import 'package:schoenen/providers/fireprov.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // getData() {
  //   var inst = FirebaseFirestore.instance;
  //   var userId = FirebaseAuth.instance.currentUser;

  //   inst.collection(userId!.uid).get().then((res) {
  //     res.docs.forEach((element) {
  //       print(element.data()['afstand']);
  //       shoeWidgets.add(ShoeCard(
  //           key: UniqueKey(),
  //           naam: element.data()['naam'],
  //           afstand: double.parse(element.data()['afstand'])));
  //     });
  //     setState(() {
  //       print("setting state");
  //     });
  //   });
  // }

  var now = DateFormat('EEEE, d/M/y').format(DateTime.now());
  var nowA = DateTime.now();

  @override
  void initState() {
    super.initState();
    // getData();
    setState(() {});
  }

  Widget build(BuildContext context) {
    List<Widget> shoeWidgets = [];
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var fireProv = Provider.of<FireProv>(context, listen: true);
    var fireStream = Provider.of<List>(context, listen: true);

    fireStream.forEach((e) {
      shoeWidgets.add(ShoeCard(
          key: UniqueKey(),
          afstand: double.parse(e.data()['afstand']),
          naam: e.data()['naam'],
          laatstBewerkt: e.data()['laatst_bewerkt'].toString(),
          ));
    });

    return Scaffold(
      backgroundColor: themeProv.backgroundColor,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      now,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    PopupMenuButton(
                      color: themeProv.backgroundColor,
                      elevation: 0,
                      onSelected: (value) {
                        Provider.of<ThemeProv>(context, listen: false)
                            .changeTheme(value);
                      },
                      child: const Text(
                        'Thema',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 'blue',
                            child: Center(
                              child: Text(
                                'Blauw',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        const PopupMenuItem(
                            value: 'pink',
                            child: Center(
                              child: Text(
                                'Roze',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        const PopupMenuItem(
                            value: 'green',
                            child: Center(
                              child: Text(
                                'Groen',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        const PopupMenuItem(
                            value: 'orange',
                            child: Center(
                              child: Text(
                                'Oranje',
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      ],
                    )
                  ]),
            ),
          ),
          Column(
            children: shoeWidgets,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/newshoe');
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Nieuwe Schoen',
        ),
        backgroundColor: themeProv.btnColor,
      ),
    );
  }
}
