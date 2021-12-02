import 'package:flutter/material.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';

class ShoeCard extends StatelessWidget {
  late double afstand;
  late String naam;
  ShoeCard({
    Key? key,
    required this.afstand,
    required this.naam,
  }) : super(key: key);

  @override


  Widget build(BuildContext context) {

  var themeProv = Provider.of<ThemeProv>(context, listen: true);
  
    return SafeArea(
      child: Center(
        child: Card(
            elevation: 0,
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: 170,
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 120, child: themeProv.image),
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
