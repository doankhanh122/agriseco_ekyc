import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/custom_button_1.dart';
import 'package:agriseco/src/components/shared/custom_button_2.dart';
import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

import '../../agriseco.dart';

const String contractLink =
    'https://hopdong.agr.vn/FileExportReport2/PrintFlex/A/6d35fff4fa305c74e76fef5664abc53d_';

class SixthPage extends StatefulWidget {
  final ValueChanged<bool> isDisableBottomBtn;

  const SixthPage({Key key, this.isDisableBottomBtn}) : super(key: key);

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  bool _isShowContractDetail;
  bool _isShowSignContract;
  bool _isFinish;
  ValueNotifier<bool> _isLoadingImage = ValueNotifier(true);

  @override
  void initState() {
    _isShowContractDetail = false;
    _isShowSignContract = false;
    _isFinish = false;
    _isLoadingImage.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingImage.dispose();
    super.dispose();
  }

  TextStyle resultTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_isFinish) {
      return PageLayout(
        title: 'Chào mừng đến với Agriseco',
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên tài khoản: ĐOÀN NGỌC KHÁNH',
                style: resultTextStyle,
              ),
              Text(
                'Số tài khoản: 008C007772',
                style: resultTextStyle,
              ),
              Divider(
                color: kBackgroundColor,
              ),
              Text(
                'Thông tin đăng nhập tài khoản đã được gửi đến số điện thoại/email đăng ký của Quý khách',
                textAlign: TextAlign.justify,
                style: resultTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: CustomButton1(label: 'Đăng nhập', onTab: () {})),
            ],
          ),
        ),
      );
    }
    return PageLayout(
      title: 'Hoàn tất hợp đồng',
      content: Column(
        children: [
          DetailRowWithCircleLead(
            child: Flexible(
              child: Text(
                  'Vui lòng đọc kỹ hợp đồng. Sau khi đọc hết hợp đồng, ấn nút "Đồng ý ký hợp đồng" để tiếp tục'),
            ),
          ),
          !_isShowContractDetail
              ? (Stack(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.5,
                            child: ClipRRect(
                              clipper: _ContractFrameClipper(),
                              child: Container(
                                child: _NetworkImage(
                                  imageUrl: '$contractLink\1.jpg',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: CustomButton2(
                        label: 'XEM THÊM',
                        onTab: () {
                          setState(() {
                            _isShowContractDetail = true;
                          });
                        },
                      ),
                    ),
                  ],
                ))
              : Container(),
          _isShowContractDetail
              ? _ContractDetail(
                  linkContract: contractLink,
                  hideContractCallback: () {
                    setState(() {
                      _isShowContractDetail = false;
                    });
                  },
                )
              : Container(),
          !_isShowSignContract
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton1(
                      label: 'Đồng ý ký hợp đồng',
                      onTab: () {
                        setState(() {
                          _isShowSignContract = true;
                        });
                      }),
                )
              : Container(),
          _isShowSignContract
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _SignContract(
                    signContractCallback: () {
                      setState(() {
                        _isFinish = true;
                      });
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class _ContractFrameClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    RRect rect = RRect.fromLTRBR(
      size.width * 0.05,
      8,
      size.width * 0.95,
      size.width * 0.9 * 3 / 4,
      Radius.circular(0),
    );
    // Rect rect = Rect.fromLTRB(
    //   size.width * 0.05,
    //   size.height * 0.3,
    //   size.width * 0.95,
    //   size.height * 0.7,
    // );

    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}

class _ContractDetail extends StatelessWidget {
  const _ContractDetail(
      {@required this.linkContract, @required this.hideContractCallback});
  final String linkContract;
  final VoidCallback hideContractCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InteractiveViewer(
          panEnabled: true,
          child: Column(
            children: [
              _NetworkImage(imageUrl: '$linkContract\1.jpg'),
              _NetworkImage(imageUrl: '$linkContract\2.jpg'),
              _NetworkImage(imageUrl: '$linkContract\3.jpg'),
              _NetworkImage(imageUrl: '$linkContract\4.jpg'),
              _NetworkImage(imageUrl: '$linkContract\5.jpg'),
              _NetworkImage(imageUrl: '$linkContract\6.jpg'),
              _NetworkImage(imageUrl: '$linkContract\7.jpg'),
              _NetworkImage(imageUrl: '$linkContract\8.jpg'),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: CustomButton2(
            label: 'THU GỌN',
            onTab: () {
              hideContractCallback.call();
            },
          ),
        ),
      ],
    );
  }
}

class _NetworkImage extends StatelessWidget {
  _NetworkImage({
    @required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        // return Text('Loading...');

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace stackTrace) {
        return Text('Không tải được, vui lòng thử lại!');
      },
    );
  }
}

class _SignContract extends StatelessWidget {
  const _SignContract({this.signContractCallback});

  final VoidCallback signContractCallback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        DetailRowWithCircleLead(
          child: Flexible(
            child: Text(
                'Quý khách vui lòng hoàn thiện hồ sơ trong vòng 30 ngày kể từ ngày mở tài khoản chứng khoán trực tuyến'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Nhập mã xác thực được gửi đến 0123456789'),
                OTPTextField(
                  fieldWidth: size.width * 0.5,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton1(
            label: 'Ký hợp đồng',
            onTab: () {
              signContractCallback.call();
            }),
      ],
    );
  }
}

class OTPTextField extends StatefulWidget {
  const OTPTextField({this.length = 6, this.fieldWidth = 30});

  final int length;
  final double fieldWidth;

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<TextEditingController> _textControllers;
  List<FocusNode> _focusNodes;

  @override
  void initState() {
    _textControllers = List<TextEditingController>.filled(widget.length, null,
        growable: false);
    _focusNodes = List<FocusNode>.filled(widget.length, null, growable: false);

    super.initState();
  }

  @override
  void dispose() {
    _textControllers.forEach((controller) {
      controller.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(widget.length, (index) {
      return buildTextField(context, index);
    }));
  }

  Widget buildTextField(BuildContext context, int index) {
    FocusNode focusNode = _focusNodes[index];
    TextEditingController textEditingController = _textControllers[index];

    // if focus node doesn't exist, create it.
    if (focusNode == null) {
      _focusNodes[index] = FocusNode();
      focusNode = _focusNodes[index];
      focusNode?.addListener((() => handleFocusChange(index)));
    }
    if (textEditingController == null) {
      _textControllers[index] = TextEditingController();
      textEditingController = _textControllers[index];
    }

    final isLast = index == widget.length - 1;

    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 8),
      width: widget.fieldWidth / widget.length + 10,
      height: (widget.fieldWidth / widget.length) * 2,
      child: TextField(
        controller: _textControllers[index],
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontWeight: FontWeight.bold),
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          filled: true,
          fillColor: kGreenColor,
          counterText: '',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kBackgroundColor),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kBackgroundColor),
              borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: (String str) {
          if (str.isNotEmpty) _focusNodes[index].unfocus();
          if (index + 1 != widget.length && str.isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          if (str.isEmpty) {
            if (index == 0) return;
            _focusNodes[index].unfocus();
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  void handleFocusChange(int index) {
    FocusNode focusNode = _focusNodes[index];
    TextEditingController controller = _textControllers[index];

    if (focusNode == null || controller == null) return;

    if (focusNode.hasFocus) {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }
  }
}
