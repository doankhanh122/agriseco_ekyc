import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

import 'agr_keyboard_visibile_builder.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    this.controller,
    this.initialValue,
    required this.dropDownList,
    this.padding,
    this.textStyle,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
    this.keyboardType,
    this.listSpace = 0,
    this.dropDownItemCount = 6,
    this.listTextStyle,
    this.listPadding,
    // this.singleController,
  })  : assert(initialValue == null || controller == null),
        assert(!(controller != null &&
            !(controller is SingleValueDropDownController))),
        singleController = controller,
        super(key: key);

  final dynamic controller;
  final dynamic initialValue;
  final List<DropdownItem>? dropDownList;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final ValueSetter? onChanged;

  final FormFieldValidator<String>? validator;
  final bool isEnabled;
  final TextInputType? keyboardType;

  final double listSpace;
  final int dropDownItemCount;

  ///dropdown list item text style
  final TextStyle? listTextStyle;

  ///dropdown List item padding
  final ListPadding? listPadding;

  final SingleValueDropDownController? singleController;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  late TextEditingController _cnt;
  late Animation<double> _heightFactor;
  List<DropdownItem>? _dropDownList;
  OverlayEntry? _entry;
  LayerLink _layerLink = LayerLink();

  late int _maxListItem;
  double? _height;
  late Offset _offset;
  double? _listTileHeight;
  TextStyle? _listTileTextStyle;
  late AnimationController _controller;

  ListPadding? _listPadding;
  late bool _isExpanded;
  late FocusNode _textFieldFocusNode;

  late SingleValueDropDownController _singleValueDropDownController;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = FocusNode();
    _singleValueDropDownController = SingleValueDropDownController();
    _cnt = TextEditingController();
    _isExpanded = false;
    _maxListItem = 6;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 700),
    );

    _heightFactor = _controller.drive(_easeInTween);

    _textFieldFocusNode.addListener(() {
      if (!_textFieldFocusNode.hasFocus && _isExpanded) {
        _isExpanded = !_isExpanded;
        hideOverlay();
        // String text = widget.singleController!.dropDownValue!.name +
        //     "-" +
        //     widget.singleController!.dropDownValue!.value.toString();
        //
        // print(text);
        // if (text != _cnt.text) {
        //   setState(() {
        //     _cnt.clear();
        //   });
        // }

        if (_singleValueDropDownController.dropDownValue == null) {
          setState(() {
            _cnt.clear();
          });
        } else {
          String _text =
              _singleValueDropDownController.dropDownValue!.value.toString() +
                  "-" +
                  _singleValueDropDownController.dropDownValue!.name;

          if (_text != _cnt.text) {
            setState(() {
              _cnt.clear();
            });
          }
        }

        // print(_singleValueDropDownController.dropDownValue?.name);
      }
    });

    updateFunction();
  }

  Size _textWidgetSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  updateFunction({CustomDropdown? oldWidget}) {
    _dropDownList =
        _dropDownList == null ? List.from(widget.dropDownList!) : _dropDownList;
    _listPadding = widget.listPadding ?? ListPadding();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listTileTextStyle =
          (widget.listTextStyle ?? Theme.of(context).textTheme.bodySmall);

      _listTileHeight =
          _textWidgetSize("dummy Text", _listTileTextStyle).height +
              _listPadding!.top +
              _listPadding!.bottom;

      _height = _dropDownList!.length < _maxListItem
          ? _dropDownList!.length * _listTileHeight!
          : _listTileHeight! * _maxListItem.toDouble();
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
          keyboardType: widget.keyboardType,
          style: widget.textStyle,
          enabled: widget.isEnabled,
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
          // onChanged: (String inputText) {
          //   // print('Droplist lenght: ${_dropDownList.length}');
          //   // // print('_Height Overlay: ${_height}');
          //   // print(widget.singleController);
          // },
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
          validator: (value) =>
              widget.validator != null ? widget.validator!(value) : null,
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

    double dropdownListHeight = _height! + widget.listSpace;
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
                ? -dropdownListHeight - _listPadding!.top
                : dropdownListHeight + _listPadding!.top,
          ),
          child: AnimatedBuilder(
            animation: _controller.view,
            builder: buildOverlay,
          ),
        ),
      );
    });

    overlay.insert(_entry!);
  }

  void hideOverlay() {
    _controller.reverse().then<void>((void value) {
      if (_entry != null && _entry!.mounted) {
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
                onSelectedDropListItem: (DropdownItem item) {
                  hideOverlay();
                  setState(() {
                    _cnt.text = item.value.toString() + "-" + item.name;
                  });

                  _singleValueDropDownController.setDropDown(item);
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
  final List<DropdownItem>? dropDownList;
  final double? height;
  final double? listTileHeight;
  final ListPadding? listPadding;

  final ValueSetter<DropdownItem>? onSelectedDropListItem;
  final ValueSetter? onSearchedDropListItem;
  final TextEditingController? mainController;

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  late List<DropdownItem> newDropDownList;

  onItemChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        newDropDownList = List.from(widget.dropDownList!);
      } else {
        newDropDownList = widget.dropDownList!
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
    newDropDownList = List.from(widget.dropDownList!);

    onItemChanged(widget.mainController!.text);
    widget.mainController!.addListener(() {
      if (mounted) {
        onItemChanged(widget.mainController!.text);
        widget.onSearchedDropListItem!(newDropDownList);
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
                widget.onSelectedDropListItem!(newDropDownList[index]);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: widget.listPadding!.bottom,
                    top: widget.listPadding!.top),
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
  DropdownItem? dropDownValue;
  SingleValueDropDownController({DropdownItem? data}) {
    setDropDown(data);
  }
  setDropDown(DropdownItem? model) {
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
  DropdownItem({required this.name, required this.value});

  final String name;
  final int value;

  get props => [name, value];
}
