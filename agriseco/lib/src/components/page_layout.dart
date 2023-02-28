import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({
    @required this.title,
    @required this.content,
  });

  final String title;
  final Widget content;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  ScrollController scrollController;

  double _maxScrollExtent;
  double _offset;
  bool _scrollToBottom;
  bool _scrollToTop;

  @override
  void initState() {
    scrollController = ScrollController();

    // _maxScrollExtent = scrollController.position.maxScrollExtent;
    // _offset = scrollController.offset;
    _scrollToTop = false;
    _scrollToBottom = false;
    scrollController.addListener(() {
      _maxScrollExtent = scrollController.position.maxScrollExtent;
      _offset = scrollController.offset;

      if (_offset < _maxScrollExtent) {
        setState(() {
          _scrollToBottom = true;
          _scrollToTop = true;
        });
      }
    });
    super.initState();
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
        Positioned(
            bottom: 0,
            right: 0,
            child: SafeArea(
                child: Column(
              children: [
                _scrollToTop
                    ? IconButton(
                        onPressed: () {
                          scrollController.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        icon: Icon(Icons.arrow_upward_outlined),
                      )
                    : Container(),
                _scrollToBottom
                    ? IconButton(
                        onPressed: () {
                          scrollController.animateTo(_maxScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        icon: Icon(Icons.arrow_downward_outlined),
                      )
                    : Container(),
              ],
            ))),
      ],
    );
  }
}
