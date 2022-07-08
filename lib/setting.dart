import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/styles.dart';
import 'package:travel/theme_provider.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            key: Key(Theme.of(context).brightness.toString()),
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : mainBlack,
              ),
            ),
          ),
          Positioned.fill(
            top: 80,
            child: Align(
              alignment: Alignment.topCenter,
              child: Consumer<ThemeProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change app theme',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black54
                                    : white,
                          ),
                        ),
                        DropdownButton<String>(
                          value: provider.currentTheme,
                          items: [
                            // Light Mode
                            DropdownMenuItem(
                              value: 'light',
                              child: Text(
                                'Light',
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : white,
                                ),
                              ),
                            ),

                            // Dark Mode
                            DropdownMenuItem(
                              value: 'dark',
                              child: Text(
                                'Dark',
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : white,
                                ),
                              ),
                            ),

                            // System
                            DropdownMenuItem(
                              value: 'system',
                              child: Text(
                                'System',
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : white,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (String? value) {
                            provider.changeTheme(value ?? 'system');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
