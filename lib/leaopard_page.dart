import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/styles.dart';
import 'package:travel/main_page.dart';
import 'dart:math' as math;

class Leopard extends StatelessWidget {
  const Leopard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 4.5),
        const SeventyTwo(),
        const SizedBox(height: 32),
        const TravelTitle(),
        const SizedBox(height: 32),
        TravelDescription(),
      ],
    );
  }
}

class SeventyTwo extends StatelessWidget {
  const SeventyTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
        builder: (context, notifier, animation, child) {
          return Transform.translate(
            offset: Offset(0 - 0.5 * notifier.offset, 0),
            child: Opacity(opacity: 1 - 0.6 * animation.value, child: child),
          );
        },
        child: Hider(
          child: RotatedBox(
            quarterTurns: 1,
            child: SizedBox(
              width: 380,
              child: FittedBox(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                child: Text(
                  '72',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? mainBlack
                        : white,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class TravelTitle extends StatelessWidget {
  const TravelTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: Hider(
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Travel Description',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? mainBlack
                  : white,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class TravelDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: const Hider(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'The leopard is distinguished by its well-camouflaged fur, opportunistic hunting behaviour, broad diet, and strength.',
            style: TextStyle(fontSize: 13, color: lightGrey),
          ),
        ),
      ),
    );
  }
}
