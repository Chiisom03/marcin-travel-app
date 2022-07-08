import 'package:flutter/material.dart';
import 'package:travel/main_page.dart';
import 'package:travel/styles.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? white
            : mainBlack,
      ),
      child: const MainPage(),
    );
  }
}
