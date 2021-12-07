import 'package:flutter/material.dart';

// Packages
import 'package:intl/intl.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';

// Pages
import 'package:schoenen/pages/shoedetails.dart';

// ignore: must_be_immutable
class ShoeCard extends StatelessWidget {
  late double afstand;
  late String naam;
  late String laatstBewerkt;
  ShoeCard({
    Key? key,
    required this.afstand,
    required this.naam,
    required this.laatstBewerkt
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    var now = DateTime.now();

    

    return SafeArea(
      child: Center(
        child: Card(
            elevation: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ShoeDetails(
                              imgtag: key.toString(),
                              afstand: afstand,
                              naam: naam,
                              laatstBewerkt: laatstBewerkt,
                            )));
              },
              child: SizedBox(
                height: 170,
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 120,
                        child:
                            Hero(tag: key!.toString(), child: themeProv.image)),
                    SizedBox(
                      height: 120,
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(naam),
                          const SizedBox(height: 50),
                          Text('Deze Maand: $afstand km'),
                          const SizedBox(height: 5),
                          Text('Dit Jaar: $afstand km'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
