import 'dart:async';
import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  ScrollController? scrollController;

  late double _maxScrollExtent;
  late double _offset;
  late bool _scrollToBottom;
  late bool _scrollToTop;
  bool _showScroll = false;
  Timer? _timer;

  @override
  void initState() {
    scrollController = ScrollController();

    _scrollToTop = false;
    _scrollToBottom = false;
    scrollController!.addListener(() {
      if (_timer != null) _timer!.cancel();
      _maxScrollExtent = scrollController!.position.maxScrollExtent;
      _offset = scrollController!.offset;

      _timer = Timer(Duration(seconds: 1), () {
        setState(() {
          _showScroll = false;
        });
      });

      if (_offset <= 0) {
        setState(() {
          _scrollToTop = false;
        });
      }

      if (_offset >= _maxScrollExtent) {
        setState(() {
          _scrollToBottom = false;
        });
      }

      if (_offset < _maxScrollExtent && _offset > 0) {
        setState(() {
          _scrollToBottom = true;
          _scrollToTop = true;
          _showScroll = true;
          //
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          controller: scrollController,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        widget.title,
                        style: kTileStyle,
                      ),
                    ),
                  ),
                  widget.content,
                ],
              ),
            ),
          ],
        ),
        _showScroll
            ? Positioned(
                bottom: 0,
                right: 0,
                child: SafeArea(
                  child: Row(
                    children: [
                      _scrollToTop
                          ? _CircleIconButton(
                              icon: Icon(
                                Icons.arrow_upward_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                scrollController!.animateTo(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                            )
                          : Container(),
                      _scrollToBottom
                          ? _CircleIconButton(
                              icon: Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                scrollController!.animateTo(_maxScrollExtent,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              })
                          : Container(),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
  });

  final Function onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.cyan.withOpacity(0.3),
      ),
      child: IconButton(
        onPressed: onPressed as void Function()?,
        icon: icon,
      ),
    );
  }
}
