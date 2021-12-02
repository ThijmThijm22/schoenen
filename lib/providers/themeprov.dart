import 'package:flutter/material.dart';

// Services
import 'package:schoenen/services/globals.dart';

class ThemeProv extends ChangeNotifier {
  Color backgroundColor = Globals.bgBlue;
  Color btnColor = Colors.blue;
  Image image = Image.asset('assets/run.png');

  void changeTheme(color) {
    if (color == 'blue') {
      backgroundColor = Globals.bgBlue;
      btnColor = Colors.blue;
      image = Image.asset('assets/run.png');
    } else if (color == 'pink') {
      backgroundColor = Globals.bgPink;
      btnColor = const Color.fromARGB(255, 255, 71, 236);
      image = Image.asset('assets/schoen_roze.png');
    } else if(color == 'green') {
      backgroundColor = Globals.bgGreen;
      btnColor = const Color.fromARGB(255, 52, 237, 127);
      image = Image.asset('assets/schoen_groen.png');
    } else if(color == 'orange') {
      backgroundColor = Globals.bgOrange;
      btnColor = Colors.orange;
      image = Image.asset('assets/schoen_oranje.png');
    }
    notifyListeners();
  }
}
