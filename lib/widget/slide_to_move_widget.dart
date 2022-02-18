import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shimmer/shimmer.dart';

/// Slider call to action component
class SlideActionWidget extends StatefulWidget {
  /// The size of the sliding icon
  final double sliderButtonIconSize;

  /// Tha padding of the sliding icon
  final double sliderButtonIconPadding;

  /// The offset on the y axis of the slider icon
  final double sliderButtonYOffset;

  /// If the slider icon rotates
  final bool sliderRotate;

  /// The child that is rendered instead of the default Text widget
  final Widget child;

  /// The height of the component
  final double height;

  /// The color of the inner circular button, of the tick icon of the text.
  /// If not set, this attribute defaults to primaryIconTheme.
  final Color innerColor;

  /// The color of the external area and of the arrow icon.
  /// If not set, this attribute defaults to accentColor from your theme.
  final Color outerColor;

  /// The text showed in the default Text widget
  final String text;

  /// Text style which is applied on the Text widget.
  ///
  /// By default, the text is colored using [innerColor].
  final TextStyle textStyle;

  /// The borderRadius of the sliding icon and of the background
  final double borderRadius;

  /// Callback called on submit
  /// If this is null the component will not animate to complete
  final VoidCallback onSubmit;

  /// Elevation of the component
  final double elevation;

  /// The widget to render instead of the default icon
  final Widget sliderButtonIcon;

  /// The widget to render instead of the default submitted icon
  final Widget submittedIcon;

  /// The duration of the animations
  final Duration animationDuration;

  /// If true the widget will be reversed
  final bool reversed;

  /// the alignment of the widget once it's submitted
  final Alignment alignment;

  /// Create a new instance of the widget
  const SlideActionWidget({
    Key key,
    this.sliderButtonIconSize = 24,
    this.sliderButtonIconPadding = 16,
    this.sliderButtonYOffset = 0,
    this.sliderRotate = true,
    this.height = 70,
    this.outerColor,
    this.borderRadius = 52,
    this.elevation = 6,
    this.animationDuration = const Duration(milliseconds: 300),
    this.reversed = false,
    this.alignment = Alignment.center,
    this.submittedIcon,
    this.onSubmit,
    this.child,
    this.innerColor,
    this.text,
    this.textStyle,
    this.sliderButtonIcon,
  }) : super(key: key);
  @override
  SlideActionWidgetState createState() => SlideActionWidgetState();
}

/// Use a GlobalKey to access the state. This is the only way to call [SlideActionWidgetState.reset]
class SlideActionWidgetState extends State<SlideActionWidget>
    with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _sliderKey = GlobalKey();
  double _dx = 0;
  double _maxDx = 0;
  double get _progress => _dx == 0 ? 0 : _dx / _maxDx;
  double _endDx = 0;
  double _dz = 1;
  double _initialContainerWidth, _containerWidth;
  double _checkAnimationDx = 0;
  bool submitted = false;
  AnimationController _checkAnimationController,
      _shrinkAnimationController,
      _resizeAnimationController,
      _textAnimationController,
      _cancelAnimationController;
  Animation _textAnimation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(widget.reversed ? pi : 0),
        child: Container(
            key: _containerKey,
            height: widget.height,
            width: _containerWidth,
            constraints: _containerWidth != null
                ? null
                : BoxConstraints.expand(height: widget.height),
            child: Material(
              color: _progress > 0.2
                  ? Colors.white30.withOpacity(_progress)
                  : widget.outerColor,
              // widget.outerColor ?? Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: submitted
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(widget.reversed ? pi : 0),
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: <Widget>[
                            widget.submittedIcon ??
                                Icon(
                                  Icons.done,
                                  color: Colors.black,
                                ),
                            Positioned.fill(
                              right: 0,
                              child: Transform(
                                transform: Matrix4.rotationY(
                                    _checkAnimationDx * (pi / 2)),
                                alignment: Alignment.centerRight,
                                child: Container(
                                  color: widget.outerColor ??
                                      Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.white,
                              child: OutlineGradientButton(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.redAccent, Colors.white]),
                                strokeWidth: 2.9,
                                padding: EdgeInsets.zero,
                                radius: Radius.circular(50),
                                child: Builder(builder: (context) {
                                  return Container(
                                    // color: Colors.white,
                                    height: widget.height,
                                    width: _containerWidth,
                                    constraints: _containerWidth != null
                                        ? null
                                        : BoxConstraints.expand(
                                            height: widget.height),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              // color: Colors.white,
                              height: widget.height,
                              width: _containerWidth,
                              constraints: _containerWidth != null
                                  ? null
                                  : BoxConstraints.expand(
                                      height: widget.height),
                              child: Material(
                                color: _progress > 0.2
                                    ? Colors.red.withOpacity(_progress)
                                    : widget.outerColor,
                                // widget.outerColor ?? Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.circular(widget.borderRadius),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Opacity(
                                    opacity: 1 - 1 * _progress,
                                    child: Transform(
                                      alignment: Alignment.centerLeft,
                                      transform: Matrix4.rotationY(
                                          widget.reversed ? pi : 0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        child: ShaderMask(
                                          child: Text(
                                            widget.text ?? 'Slide to act',
                                            textAlign: TextAlign.center,
                                            style: widget.textStyle,
                                          ),
                                          shaderCallback: (rect) {
                                            return LinearGradient(
                                              stops: [
                                                _textAnimation.value - 0.5,
                                                _textAnimation.value + 0.5,
                                              ],
                                              colors: [
                                                Colors.red,
                                                Colors.red[100],
                                              ],
                                            ).createShader(rect);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        Positioned(
                          left: widget.sliderButtonYOffset + 5,
                          child: Opacity(
                            opacity: _progress,
                            child: AnimatedContainer(
                              duration: widget.animationDuration,
                              width: _dx == 0 ? _dx : _containerWidth - 15,
                              height: widget.height - 20,
                              // margin: EdgeInsets.only(top: 15, bottom: 15),
                              child: Stack(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.red[100],
                                    child: AnimatedContainer(
                                      duration: widget.animationDuration,
                                      width:
                                          _dx == 0 ? _dx : _containerWidth - 15,
                                      height: widget.height - 20,
                                      // margin:
                                      // EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          color: _progress > 0.2
                                              ? Colors.red
                                                  .withOpacity(_progress)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                              widget.borderRadius)
                                          // only(
                                          //     topLeft: Radius.circular(
                                          //         widget.borderRadius),
                                          //     bottomLeft: Radius.circular(
                                          //         widget.borderRadius))
                                          // circular(widget.borderRadius),
                                          ),
                                      // child:
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: widget.submittedIcon),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   left: widget.sliderButtonYOffset,
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //         left: 10, top: 15, bottom: 15),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius:
                        //           BorderRadius.circular(widget.borderRadius),
                        //     ),
                        //     width: _dx,
                        //     height: widget.height,
                        //   ),
                        // )
                        Positioned(
                          left: widget.sliderButtonYOffset,
                          child: Transform.scale(
                            scale: _dz,
                            origin: Offset(_dx, 0),
                            child: Transform.translate(
                              offset: Offset(_dx, 0),
                              child: Container(
                                key: _sliderKey,
                                child: GestureDetector(
                                  onHorizontalDragUpdate:
                                      onHorizontalDragUpdate,
                                  onHorizontalDragEnd: (details) async {
                                    _endDx = _dx;
                                    if (_progress <= 0.8 ||
                                        widget.onSubmit == null) {
                                      _cancelAnimation();
                                    } else {
                                      await _resizeAnimation();

                                      // await _shrinkAnimation();

                                      await _checkAnimation();

                                      widget.onSubmit();
                                    }
                                  },
                                  child: OutlineGradientButton(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.redAccent,
                                          Colors.white
                                        ]),
                                    strokeWidth: 2.8,
                                    padding: EdgeInsets.zero,
                                    radius: Radius.circular(50),
                                    child: Builder(builder: (context) {
                                      return Material(
                                        borderRadius: BorderRadius.circular(
                                            widget.borderRadius),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          // padding: EdgeInsets.all(
                                          //     widget.sliderButtonIconPadding),
                                          alignment: Alignment.centerRight,
                                          child: Transform.rotate(
                                            angle: widget.sliderRotate
                                                ? -pi * _progress
                                                : 0,
                                            child: Center(
                                              child: widget.sliderButtonIcon ??
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    size: widget
                                                        .sliderButtonIconSize,
                                                    color: widget.outerColor ??
                                                        Theme.of(context)
                                                            .accentColor,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        color: widget.innerColor ??
                                            Theme.of(context)
                                                .primaryIconTheme
                                                .color,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
            // }),
            ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dx = (_dx + details.delta.dx).clamp(0.0, _maxDx);
    });
  }

  /// Call this method to revert the animations
  Future reset() async {
    await _checkAnimationController.reverse().orCancel;

    submitted = false;

    await _shrinkAnimationController.reverse().orCancel;

    await _resizeAnimationController.reverse().orCancel;

    await _cancelAnimation();
  }

  Future _checkAnimation() async {
    _checkAnimationController.reset();

    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _checkAnimationController,
      curve: Curves.slowMiddle,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _checkAnimationDx = animation.value;
        });
      }
    });
    await _checkAnimationController.forward().orCancel;
  }

  Future _shrinkAnimation() async {
    _shrinkAnimationController.reset();

    final diff = _initialContainerWidth - widget.height;
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shrinkAnimationController,
      curve: Curves.easeOutCirc,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _containerWidth = _initialContainerWidth - (diff * animation.value);
        });
      }
    });

    setState(() {
      submitted = true;
    });
    await _shrinkAnimationController.forward().orCancel;
  }

  Future _resizeAnimation() async {
    _resizeAnimationController.reset();

    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _resizeAnimationController,
      curve: Curves.easeInBack,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dz = 1 - animation.value;
        });
      }
    });
    await _resizeAnimationController.forward().orCancel;
  }

  Future _cancelAnimation() async {
    _cancelAnimationController.reset();
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _cancelAnimationController,
      curve: Curves.fastOutSlowIn,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dx = (_endDx - (_endDx * animation.value));
        });
      }
    });
    _cancelAnimationController.forward().orCancel;
  }

  @override
  void initState() {
    super.initState();

    _cancelAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _checkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _shrinkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _resizeAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _textAnimationController.repeat(reverse: true);
    _textAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_textAnimationController)
      ..addListener(() {
        if (mounted) setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox containerBox =
          _containerKey.currentContext.findRenderObject() as RenderBox;
      _containerWidth = containerBox.size.width;
      _initialContainerWidth = _containerWidth;

      final RenderBox sliderBox =
          _sliderKey.currentContext.findRenderObject() as RenderBox;
      final sliderWidth = sliderBox.size.width;

      _maxDx =
          _containerWidth - (sliderWidth / 2) - 40 - widget.sliderButtonYOffset;
    });
  }

  @override
  void dispose() {
    _cancelAnimationController.dispose();
    _checkAnimationController.dispose();
    _shrinkAnimationController.dispose();
    _resizeAnimationController.dispose();
    _textAnimationController.dispose();
    _textAnimation.removeListener(() {});
    super.dispose();
  }
}
