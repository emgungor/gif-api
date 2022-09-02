import 'package:flutter/material.dart';

import 'homepage.dart';

void main () {
  runApp(GifAPI());
}

class GifAPI extends StatelessWidget {
  const GifAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
