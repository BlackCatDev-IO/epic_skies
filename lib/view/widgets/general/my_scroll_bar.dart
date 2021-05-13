import 'package:flutter/material.dart';

// solves issue of scrollbar not showing up until user scrolls
// even when alwaysVisible is set to true
class MyScrollbar extends StatefulWidget {
  final ScrollableWidgetBuilder builder;
  final ScrollController? scrollController;

  const MyScrollbar({
    this.scrollController,
    required this.builder,
  });

  @override
  _MyScrollbarState createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar> {
  ScrollbarPainter? _scrollbarPainter;
  late ScrollController _scrollController;
  Orientation? _orientation;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _updateScrollPainter(_scrollController.position);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollbarPainter = _buildMaterialScrollbarPainter();
  }

  @override
  void dispose() {
    _scrollbarPainter!.dispose();
    super.dispose();
  }

  ScrollbarPainter _buildMaterialScrollbarPainter() {
    return ScrollbarPainter(
      color: Colors.white60,
      textDirection: Directionality.of(context),
      thickness: 2.5,
      radius: const Radius.circular(30),
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
      padding: MediaQuery.of(context).padding,
    );
  }

  bool _updateScrollPainter(ScrollMetrics position) {
    _scrollbarPainter!.update(
      position,
      position.axisDirection,
    );
    return false;
  }

  @override
  void didUpdateWidget(MyScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateScrollPainter(_scrollController.position);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        _orientation ??= orientation;
        if (orientation != _orientation) {
          _orientation = orientation;
          _updateScrollPainter(_scrollController.position);
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _updateScrollPainter(notification.metrics),
          child: CustomPaint(
            painter: _scrollbarPainter,
            child: widget.builder(context, _scrollController),
          ),
        );
      },
    );
  }
}
