import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel/home.dart';
import 'package:travel/styles.dart';
import 'package:travel/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const Travel(),
    ),
  );
}

class Travel extends StatelessWidget {
  const Travel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtColor =
        Theme.of(context).brightness == Brightness.light ? mainBlack : white;
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return Center(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Travel',
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            themeMode: provider.themeMode,
            home: const Home(),
          ),
        );
      },
    );
  }
}
