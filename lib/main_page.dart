// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/leaopard_page.dart';
import 'package:travel/res_widgets.dart';
import 'package:travel/setting.dart';
import 'package:travel/styles.dart';
import 'dart:math' as math;

class PageOffsetNotifier extends ChangeNotifier {
  double _offset = 0;
  double _page = 0;

  PageOffsetNotifier(PageController _pageController) {
    _pageController.addListener(() {
      _offset = _pageController.offset;
      _page = _pageController.page!;
      notifyListeners();
    });
  }
  double get offset => _offset;
  double get page => _page;
}

class MapAnimationNotifier with ChangeNotifier {
  final AnimationController _animationController;

  MapAnimationNotifier(this._animationController) {
    _animationController.addListener(_onAnimationControllerChanged);
  }
  double get value => _animationController.value;

  void forward() => _animationController.forward();
  void reverse() => _animationController.reverse();
  void _onAnimationControllerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeListener(_onAnimationControllerChanged);
  }
}

double topStart = 128.0 + 80 + 400 + 48;
double topEnd = 128.0 + 48 + 38;
double oneThird = (topStart - topEnd) / 3;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _mapAnimationController;
  final PageController _pageController = PageController();
  double get maxHeight => 400.0 + 32 + 24;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _mapAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: ListenableProvider.value(
        value: _animationController,
        child: ChangeNotifierProvider(
          create: (_) => MapAnimationNotifier(_mapAnimationController),
          child: Scaffold(
            body: Stack(
              children: [
                MapImage(),
                SafeArea(
                  child: GestureDetector(
                    onVerticalDragUpdate: _handleDragUpdate,
                    onVerticalDragEnd: _handleDragEnd,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const LeopardImage(),
                        PageView(
                          controller: _pageController,
                          physics: const ClampingScrollPhysics(),
                          children: const <Widget>[
                            Leopard(),
                            Vulture(),
                          ],
                        ),
                        const AppBar(),
                        const LeopardImage(),
                        const VultureImage(),
                        ArrowIcon(),
                        ShareButton(),
                        PageIndicator(),
                        TravelDetail(),
                        StartCamp(),
                        StartTime(),
                        BaseCamp(),
                        BaseTime(),
                        Distance(),
                        HorizontalTravelDots(),
                        MapBtn(),
                        VerticalTravelDots(),
                        VultureIconLabel(),
                        LeopardIconLabel(),
                        CurvedRoute(),
                        MapBaseCamp(),
                        MapLeopards(),
                        MapVulture(),
                        MapStartCamp(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= (details.primaryDelta! / maxHeight);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _animationController.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(velocity: math.min(-2.0, -flingVelocity));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class MapImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double scale = (1 + 0.3 * (1 - notifier.value));
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(scale, scale)
            ..rotateZ(0.05 * math.pi * (1 - notifier.value)),
          child: Opacity(opacity: notifier.value, child: child),
        );
      },
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/images/map.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Hider extends StatelessWidget {
  final Widget child;
  const Hider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: ((context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - (2 * notifier.value)),
          child: child,
        );
      }),
      child: child,
    );
  }
}

// App Bar Widget
class AppBar extends StatelessWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Text(
              'Chiisom',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : white,
              ),
            ),
            const Spacer(),
            Hider(
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Setting())),
                child: const Icon(Icons.settings_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeopardImage extends StatelessWidget {
  const LeopardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          left: -0.85 * notifier.offset,
          width: MediaQuery.of(context).size.width * 1.6,
          child: Transform.scale(
            alignment: const Alignment(0.6, 0),
            scale: 1 - 0.1 * animation.value,
            child: Opacity(
              opacity: 1 - 0.6 * animation.value,
              child: child,
            ),
          ),
        );
      },
      child: Hider(
        child: IgnorePointer(
          child: Center(
            child: Image.asset(
              'assets/images/leopard.png',
            ),
          ),
        ),
      ),
    );
  }
}

class VultureImage extends StatelessWidget {
  const VultureImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          left:
              1.2 * MediaQuery.of(context).size.width - 0.85 * notifier.offset,
          child: Transform.scale(
            scale: 1 - 0.1 * animation.value,
            child: Opacity(
              opacity: 1 - 0.6 * animation.value,
              child: child!,
            ),
          ),
        );
      },
      child: Hider(
        child: IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Image.asset(
              'assets/images/vulture.png',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hider(
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, _) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 0.5, color: lightGrey),
                      color: notifier.page.round() == 0 ? white : mainBlack,
                    ),
                    height: 6,
                    width: 6,
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: lightGrey),
                      color: notifier.page.round() != 0 ? white : mainBlack,
                    ),
                    height: 6,
                    width: 6,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MapBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 18,
      bottom: 0,
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity = math.max(0, 4 * notifier.page - 3);
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: TextButton(
          child: Text(
            'ON MAP',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).brightness == Brightness.light
                  ? lightGrey
                  : white,
            ),
          ),
          onPressed: () {
            final notifier =
                Provider.of<MapAnimationNotifier>(context, listen: false);
            notifier.value == 0 ? notifier.forward() : notifier.reverse();
          },
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 24,
      bottom: 16,
      child: Icon(Icons.share_outlined),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: 128.0 + (1 - animation.value) * (400 + 32 + 43),
          right: 24,
          child: child!,
        );
      },
      child: const Hider(
        child: Icon(
          Icons.keyboard_arrow_up,
          size: 28,
          color: lighterGrey,
        ),
      ),
    );
  }
}

class MapBaseCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: 128.0 + 80,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: 30,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Base Camp',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.light
                ? mainBlack
                : white,
          ),
        ),
      ),
    );
  }
}

class MapLeopards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: 128.0 + 80 + oneThird,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 30),
        child: SmallAnimalIcon(
          isVulture: false,
          showLine: false,
        ),
      ),
    );
  }
}

class MapVulture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: 128.0 + 80 + 2 * oneThird,
          right: 50,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const SmallAnimalIcon(
        isVulture: true,
        showLine: false,
      ),
    );
  }
}

class MapStartCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topStart - 4,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Start Camp',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.light
                ? mainBlack
                : white,
          ),
        ),
      ),
    );
  }
}

// Vulture Page
class Vulture extends StatelessWidget {
  const Vulture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hider(child: VultureCircle()),
    );
  }
}

class VultureIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        double topStart = 128.0 + 80 + 400 + 48;
        double topEnd = 128.0 + 48 + 38;
        double oneThird = (topStart - topEnd) / 3;
        double opacity;
        if (animation.value < 2 / 3) {
          opacity = 0;
        } else if (notifier.value == 0) {
          opacity = 3 * (animation.value - 2 / 3);
        } else if (notifier.value < 0.33) {
          opacity = 1 - 3 * notifier.value;
        } else {
          opacity = 0;
        }
        return Positioned(
          top: topEnd + 2 * oneThird - 28 - 16 - 7,
          right: 26 + animation.value,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const SmallAnimalIcon(isVulture: true, showLine: true),
    );
  }
}

class LeopardIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        double opacity;
        if (animation.value < 3 / 4) {
          opacity = 0;
        } else if (notifier.value == 0) {
          opacity = 4 * (animation.value - 3 / 4);
        } else if (notifier.value < 0.33) {
          opacity = 1 - 3 * notifier.value;
        } else {
          opacity = 0;
        }
        return Positioned(
          top: topEnd + oneThird - 28 - 16 - 7,
          left: 26 + animation.value,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: const SmallAnimalIcon(isVulture: false, showLine: true),
    );
  }
}

class SmallAnimalIcon extends StatelessWidget {
  final bool isVulture;
  final bool showLine;
  const SmallAnimalIcon({
    Key? key,
    required this.isVulture,
    required this.showLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showLine && isVulture)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 1,
            width: 16,
            color: white,
          ),
        const SizedBox(width: 24),
        Column(
          children: [
            Image.asset(
              isVulture
                  ? 'assets/images/vultures.png'
                  : 'assets/images/leopards.png',
              width: 28,
              height: 28,
            ),
            SizedBox(height: showLine ? 16 : 0),
            Text(
              isVulture ? 'Vultures' : 'Leopards',
              style: TextStyle(
                fontSize: showLine ? 14 : 12,
                color: isLightTheme ? lightGrey : white,
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        if (showLine && !isVulture)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 1,
            width: 14,
            color: isLightTheme ? lightGrey : white,
          ),
      ],
    );
  }
}

class CurvedPainter extends CustomPainter {
  final double animationValue;
  late double swidth;

  CurvedPainter(this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

// Animation Code
    double interpolate(double x) {
      return swidth / 2 + (x - swidth / 2) * animationValue;
    }

    paint.color = white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    swidth = size.width;

    var startPoint = Offset(interpolate(swidth / 2 + 20), 4);
    var controlPoint1 = Offset(interpolate(swidth / 2 + 60), size.height / 4);
    var controlPoint2 = Offset(interpolate(swidth / 2 + 20), size.height / 4);
    var endPoint = Offset(interpolate(swidth / 2 + 55 + 4), size.height / 3);

    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 = Offset(interpolate(swidth / 2 + 100), size.height / 2);
    controlPoint2 = Offset(interpolate(swidth / 2 + 20), size.height / 2 + 40);
    endPoint =
        Offset(interpolate(swidth / 2 + 50 + 2), 2 * size.height / 3 + 1 - 5);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 =
        Offset(interpolate(swidth / 2 - 20), 2 * size.height / 3 - 10);
    controlPoint2 =
        Offset(interpolate(swidth / 2 + 20), 5 * size.height / 6 - 10);
    endPoint = Offset(interpolate(swidth / 2), 5 * size.height / 6 + 2);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 = Offset(interpolate(swidth / 2 - 90), size.height - 80);
    controlPoint2 = Offset(interpolate(swidth / 2 - 40), size.height - 50);
    endPoint = Offset(interpolate(swidth / 2 - 50), size.height - 4);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
