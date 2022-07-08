// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/main_page.dart';
import 'package:travel/styles.dart';

import 'dart:math' as math;

class VultureCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        late double multiplier;
        if (animation.value == 0) {
          multiplier = math.max(0, 4 * notifier.page - 3);
        } else {
          multiplier = math.max(0, 1 - 6 * animation.value);
        }
        double size = MediaQuery.of(context).size.width * 0.5 * multiplier;
        return Container(
          margin: const EdgeInsets.only(bottom: 250),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: lightGrey,
          ),
          height: size,
          width: size,
        );
      },
    );
  }
}

class TravelDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          top: 128.0 + (1 - animation.value) * (400 + 32 + 43),
          left: MediaQuery.of(context).size.width - notifier.offset,
          child: Opacity(
            opacity: math.max(0, 4 * notifier.page - 3),
            child: child,
          ),
        );
      },
      child: Hider(
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Travel Detail',
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

class StartCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128 + 400 + 48 + 80.0,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Hider(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Start Camp',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.light
                    ? mainBlack
                    : white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StartTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128 + 400 + 48 + 125.0,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Center(
          child: Hider(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '6:00 am',
                style: TextStyle(
                  fontSize: 14,
                  color: lightGrey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BaseCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128.0 + 80 + (1 - animation.value) * (400 + 48),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Hider(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Base Camp',
            style: TextStyle(
              fontSize: 14,
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

class BaseTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128.0 + 125 + (1 - animation.value) * (400 + 48),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const Center(
        child: Hider(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '7:30 am',
              style: TextStyle(
                fontSize: 14,
                color: lightGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Distance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128 + 400 + 48 + 125.0,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Hider(
        child: Center(
          child: Text(
            '72 km',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.light
                  ? lightGrey
                  : white,
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        if (animation.value < 1 / 6 || notifier.value > 0) {
          return Container();
        }
        double topStart = 128.0 + 80 + 400 + 48;
        double topEnd = 128.0 + 48 + 38;
        double top =
            topEnd + (1 - (1.2 * (animation.value - 1 / 6))) * (400 + 32);
        double bottom = MediaQuery.of(context).size.height - topStart - 43;
        double oneThird = (topStart - topEnd) / 3;
        return Positioned(
          top: top,
          bottom: bottom,
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 2,
                  height: double.infinity,
                  color: Theme.of(context).brightness == Brightness.light
                      ? lightGrey
                      : white,
                ),
                Positioned(
                  top: top > oneThird + topEnd ? 0 : oneThird + topEnd - top,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isLightTheme ? mainBlack : white,
                        width: 2.5,
                      ),
                      color: isLightTheme ? white : mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Positioned(
                  top: top > 2 * oneThird + topEnd
                      ? 0
                      : 2 * oneThird + topEnd - top,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isLightTheme ? mainBlack : white,
                        width: 2.5,
                      ),
                      color: isLightTheme ? white : mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isLightTheme ? mainBlack : white,
                        width: 1,
                      ),
                      color: isLightTheme ? white : mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, -1),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.light
                          ? mainBlack
                          : white,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurvedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Consumer<MapAnimationNotifier>(
      builder: (context, animation, child) {
        if (animation.value == 0) {
          return Container();
        }
        double topStart = 128.0 + 80 + 400 + 48;
        double topEnd = 128.0 + 48 + 38;
        double bottom = MediaQuery.of(context).size.height - topStart - 43;
        double oneThird = (topStart - topEnd) / 3;
        double width = MediaQuery.of(context).size.width;
        return Positioned(
          top: topEnd,
          left: 0,
          bottom: bottom,
          right: 0,
          child: CustomPaint(
            painter: CurvedPainter(animation.value),
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 2 * oneThird,
                    right: width / 2 - 4 - animation.value * 52,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isLightTheme ? mainBlack : white,
                          width: 2.5,
                        ),
                        color: isLightTheme ? white : mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Positioned(
                    top: oneThird,
                    right: width / 2 - 4 - animation.value * 59,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isLightTheme ? mainBlack : white,
                          width: 2.5,
                        ),
                        color: isLightTheme ? white : mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 1),
                    child: Container(
                      margin: EdgeInsets.only(right: 100 * animation.value),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isLightTheme ? mainBlack : white,
                          width: 1,
                        ),
                        color: isLightTheme ? white : mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -1),
                    child: Container(
                      margin: EdgeInsets.only(left: 40 * animation.value),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).brightness == Brightness.light
                            ? mainBlack
                            : white,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HorizontalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        if (animation.value == 1) {
          return Container();
        }
        late double spacingFactor;
        late double opacity;
        if (animation.value == 0) {
          spacingFactor = math.max(0, 4 * notifier.page - 3);
          opacity = spacingFactor;
        } else {
          spacingFactor = math.max(0, 1 - 6 * animation.value);
          opacity = 1;
        }
        return Positioned(
          top: 128 + 400 + 48 + 80.0 + 4,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 11),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightGrey
                          : white,
                    ),
                    height: 6,
                    width: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 11),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightGrey
                          : white,
                    ),
                    height: 6,
                    width: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightGrey
                            : white,
                      ),
                    ),
                    height: 8,
                    width: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightGrey
                          : white,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
