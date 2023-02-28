import 'package:agriseco/src/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'agr_keyboard_visibile_builder.dart';

class CustomDropdown extends StatefulWidget {
  CustomDropdown({
    this.dropDownList,
    this.listSpace = 0,
    this.dropDownItemCount = 6,
    this.listTextStyle,
    this.listPadding,
  });

  final List<DropdownItem> dropDownList;

  final double listSpace;
  final int dropDownItemCount;

  ///dropdown list item text style
  final TextStyle listTextStyle;

  ///dropdown List item padding
  final ListPadding listPadding;

  SingleValueDropDownController singleController;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  TextEditingController _cnt;
  Animation<double> _heightFactor;
  List<DropdownItem> _dropDownList;
  OverlayEntry _entry;
  LayerLink _layerLink = LayerLink();

  int _maxListItem;
  double _height;
  Offset _offset;
  double _listTileHeight;
  TextStyle _listTileTextStyle;
  AnimationController _controller;

  ListPadding _listPadding;
  bool _isExpanded;
  FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = FocusNode();
    _cnt = TextEditingController();
    _isExpanded = false;
    _maxListItem = 6;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 700),
    );

    _heightFactor = _controller.drive(_easeInTween);

    updateFunction();
  }

  Size _textWidgetSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  updateFunction({CustomDropdown oldWidget}) {
    _dropDownList =
        _dropDownList == null ? List.from(widget.dropDownList) : _dropDownList;
    _listPadding = widget.listPadding ?? ListPadding();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listTileTextStyle =
          (widget.listTextStyle ?? Theme.of(context).textTheme.bodySmall);

      _listTileHeight =
          _textWidgetSize("dummy Text", _listTileTextStyle).height +
              _listPadding.top +
              _listPadding.bottom;

      _height = _dropDownList.length < _maxListItem
          ? _dropDownList.length * _listTileHeight
          : _listTileHeight * _maxListItem.toDouble();
    });
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // print('Height: ' + _height.toString());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _cnt.dispose();
    super.dispose();
  }

  clearFun() {
    if (_isExpanded) {
      _isExpanded = !_isExpanded;
      hideOverlay();
    }
    _cnt.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AgrKeyboardVisibileBuilder(builder: (context, isKeyboardVisible) {
      return CompositedTransformTarget(
        link: _layerLink,
        child: TextFormField(
          controller: _cnt,
          focusNode: _textFieldFocusNode,
          onTap: () {
            if (_dropDownList != null) {
              if (!_isExpanded) {
                _showOverlay();
              } else {
                hideOverlay();
              }
            }

            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          onChanged: (String inputText) {
            // print('Droplist lenght: ${_dropDownList.length}');
            // // print('_Height Overlay: ${_height}');
            // print(widget.singleController);
          },
          decoration: InputDecoration(
            suffixIcon: !_isExpanded
                ? Icon(
                    Icons.arrow_circle_down_rounded,
                    color: kYellowColor,
                  )
                : Icon(
                    Icons.arrow_circle_up_rounded,
                    color: kYellowColor,
                  ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kBackgroundColor)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kBackgroundColor)),
          ),
        ),
      );
    });
  }

  Future<void> _showOverlay() async {
    _controller.forward();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);
    double posFromTop = _offset.dy;
    double posFromBot = MediaQuery.of(context).size.height - posFromTop;

    double dropdownListHeight = _height + widget.listSpace;
    double ht = dropdownListHeight + 120;
    _entry = OverlayEntry(builder: (context) {
      return Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          targetAnchor:
              posFromBot < ht ? Alignment.topCenter : Alignment.bottomCenter,
          followerAnchor:
              posFromBot < ht ? Alignment.topCenter : Alignment.bottomCenter,
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
            0,
            posFromBot < ht
                ? -dropdownListHeight - _listPadding.top
                : dropdownListHeight + _listPadding.top,
          ),
          child: AnimatedBuilder(
            animation: _controller.view,
            builder: buildOverlay,
          ),
        ),
      );
    });

    overlay.insert(_entry);
  }

  void hideOverlay() {
    _controller.reverse().then<void>((void value) {
      if (_entry != null && _entry.mounted) {
        _entry?.remove();
        _entry = null;
      }
      //
      //   if (_entry2 != null && _entry2!.mounted) {
      //     _entry2?.remove();
      //     _entry2 = null;
      //   }
      //
      //   if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      //     _barrierOverlay?.remove();
      //     _barrierOverlay = null;
      //     _isOutsideClickOverlay = false;
      //   }
      //   _isScrollPadding = false;
    });
    _textFieldFocusNode.unfocus();
  }

  Widget buildOverlay(context, child) {
    return ClipRect(
      child: Align(
        heightFactor: _heightFactor.value,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: Card(
              elevation: 5,
              child: SingleSelection(
                mainController: _cnt,
                height: _height,
                listTileHeight: _listTileHeight,
                listPadding: _listPadding,
                dropDownList: _dropDownList,
                onSearchedDropListItem: (listItem) {
                  if (listItem != null) {}
                },
                onSelectedDropListItem: (val) {
                  hideOverlay();
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingleSelection extends StatefulWidget {
  SingleSelection({
    this.dropDownList,
    this.height,
    this.listTileHeight,
    this.listPadding,
    this.onSelectedDropListItem,
    this.onSearchedDropListItem,
    this.mainController,
  });
  final List<DropdownItem> dropDownList;
  final double height;
  final double listTileHeight;
  final ListPadding listPadding;

  final ValueSetter onSelectedDropListItem;
  final ValueSetter onSearchedDropListItem;
  final TextEditingController mainController;

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  List<DropdownItem> newDropDownList;

  onItemChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        newDropDownList = List.from(widget.dropDownList);
      } else {
        newDropDownList = widget.dropDownList
            .where((item) => (item.value.toString() + item.name)
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    newDropDownList = List.from(widget.dropDownList);

    onItemChanged(widget.mainController.text);
    widget.mainController.addListener(() {
      if (mounted) {
        onItemChanged(widget.mainController.text);
        widget.onSearchedDropListItem(newDropDownList);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SingleSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: newDropDownList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                widget.onSelectedDropListItem(newDropDownList[index]);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: widget.listPadding.bottom,
                    top: widget.listPadding.top),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(newDropDownList[index].value.toString() +
                        ' - ' +
                        newDropDownList[index].name),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SingleValueDropDownController extends ChangeNotifier {
  DropdownItem dropDownValue;
  SingleValueDropDownController({DropdownItem data}) {
    setDropDown(data);
  }
  setDropDown(DropdownItem model) {
    dropDownValue = model;
    notifyListeners();
  }

  clearDropDown() {
    dropDownValue = null;
    notifyListeners();
  }
}

class ListPadding {
  double top;
  double bottom;
  ListPadding({this.top = 15, this.bottom = 15});
}

class DropdownItem {
  DropdownItem({this.name, this.value});

  final String name;
  final int value;

  get props => [name, value];
}
