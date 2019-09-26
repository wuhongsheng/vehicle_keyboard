library vehicle_keyboard;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 车牌输入键盘
class VehicleKeyboard extends StatefulWidget {
  final callback;

  TextEditingController controller;

  VehicleKeyboard(this.callback,this.controller);

  @override
  State<StatefulWidget> createState() => VehicleKeyboardState();
}

class VehicleKeyboardState extends State<VehicleKeyboard> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFirst = true;

  final double maxHeight = 280;
  final double minHeight = 230;

  double height = 230;

  /// 键盘的整体回调，根据不同的按钮事件来进行相应的逻辑实现
  void _onKeyDown(KeyDownEvent data) {
    debugPrint("pressKey:" + data.key);

    if (data.isDelete()) {
      widget.controller.text =
          widget.controller.text.substring(0, widget.controller.text.length - 1);
      switchContent(widget.controller);
    } else if (data.isMore()) {
      setState(() {
        height = maxHeight;
        isFirst = false;
      });

    } else if (data.isProvince()) {
      setState(() {
        isFirst = true;
        height = minHeight;
      });
    } else {
      widget.controller.text += data.key;
      switchContent(widget.controller);
    }
  }


  void switchContent(TextEditingController controller) {
    setState(() {
      if (controller.text.length > 0) {
        isFirst = false;
        height = maxHeight;
      } else {
        isFirst = true;
        height = minHeight;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchContent(widget.controller);
  }
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸)
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)
      ..init(context);
    return new Container(
      color: Colors.grey[300],
      key: _scaffoldKey,
      width: double.infinity,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 0.8,
            indent: 0.0,
            color: Colors.grey,
          ),
          Container(
            width: double.infinity,
            height: 35,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Container(
                    height: 35,
                    color: Colors.white,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                        alignment: AlignmentDirectional.center,
                        onPressed: () {
                          widget.callback(new KeyDownEvent('close'));
                        },
                      ),
                    ))
              ],
            ),
          ),
          isFirst ? _Province() : _OtherKey()
        ],
      ),
    );
  }

  /// 键盘按键
  Widget _RaiseButton(String name) {
    return Container(
      width: 45,
      child: RaisedButton(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        color: Colors.white,
        textTheme: ButtonTextTheme.accent,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5)),
        onPressed: () {
          _onKeyDown(new KeyDownEvent(name));
          widget.callback(new KeyDownEvent(name));
        },
      ),
    );
  }

  /// 确定按键
  Widget _CommitButton(bool enable) {
    return Container(
      width: 90,
      child: RaisedButton(
        child: Text(
          '确定',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        color: Colors.lightBlue,
        disabledColor: Colors.grey[400],
        textTheme: ButtonTextTheme.accent,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5)),
        onPressed: enable
            ? () {
          widget.callback(new KeyDownEvent('commit'));
        }
            : null,
      ),
    );
  }

  /// 删除按键
  Widget _DelButton() {
    return Container(
      width: 60,
      child: RaisedButton(
        child: Icon(Icons.backspace),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5)),
        onPressed: () {
          _onKeyDown(new KeyDownEvent('del'));
          widget.callback(new KeyDownEvent('del'));
        },
      ),
    );
  }


  /// 切换按键
  Widget _SwitchButton(String name, String key) {
    return Container(
      width: 90,
      child: RaisedButton(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          color: Colors.white,
          textTheme: ButtonTextTheme.accent,
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          onPressed: () {
            _onKeyDown(new KeyDownEvent(key));
            widget.callback(new KeyDownEvent(key));
          }
      ),
    );
  }

  /// 车牌首字符
  Widget _Province() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('皖'),
              _RaiseButton('京'),
              _RaiseButton('津'),
              _RaiseButton('冀'),
              _RaiseButton('晋'),
              _RaiseButton('辽'),
              _RaiseButton('吉'),
              _RaiseButton('黑'),
              _RaiseButton('沪'),
              _RaiseButton('苏'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('浙'),
              _RaiseButton('渝'),
              _RaiseButton('闽'),
              _RaiseButton('赣'),
              _RaiseButton('鲁'),
              _RaiseButton('豫'),
              _RaiseButton('鄂'),
              _RaiseButton('湘'),
              _RaiseButton('粤'),
              _RaiseButton('琼'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('川'),
              _RaiseButton('贵'),
              _RaiseButton('云'),
              _RaiseButton('陕'),
              _RaiseButton('甘'),
              _RaiseButton('青'),
              _RaiseButton('蒙'),
              _RaiseButton('桂'),
              _DelButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('宁'),
              _RaiseButton('新'),
              _RaiseButton('藏'),
              SizedBox(width: 100),
              _SwitchButton('更多', 'more'),
              _CommitButton(false),
            ],
          )
        ],
      ),
    );
  }

  /// 其他字符
  Widget _OtherKey() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('1'),
              _RaiseButton('2'),
              _RaiseButton('3'),
              _RaiseButton('4'),
              _RaiseButton('5'),
              _RaiseButton('6'),
              _RaiseButton('7'),
              _RaiseButton('8'),
              _RaiseButton('9'),
              _RaiseButton('0'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('A'),
              _RaiseButton('B'),
              _RaiseButton('C'),
              _RaiseButton('D'),
              _RaiseButton('E'),
              _RaiseButton('F'),
              _RaiseButton('G'),
              _RaiseButton('H'),
              _RaiseButton('J'),
              _RaiseButton('K'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('L'),
              _RaiseButton('M'),
              _RaiseButton('N'),
              _RaiseButton('P'),
              _RaiseButton('Q'),
              _RaiseButton('R'),
              _RaiseButton('S'),
              _RaiseButton('T'),
              _RaiseButton('U'),
              _RaiseButton('v'),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('W'),
              _RaiseButton('X'),
              _RaiseButton('Y'),
              _RaiseButton('Z'),
              _RaiseButton('警'),
              _RaiseButton('学'),
              _RaiseButton('挂'),
              _RaiseButton('超'),
              _DelButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RaiseButton('使'),
              _RaiseButton('领'),
              _RaiseButton('港'),
              _RaiseButton('澳'),
              SizedBox(width: 80,),
              _SwitchButton('省份', 'province'),
              _CommitButton(true),
            ],
          )
        ],
      ),
    );
  }
}

/// 点击事件
class KeyDownEvent {
  //当前点击的按钮所代表的值
  String key;

  KeyDownEvent(this.key);

  bool isDelete() => this.key == "del";

  bool isMore() => this.key == "more";

  bool isProvince() => this.key == "province";

  bool isClose() => this.key == "close";

  bool isCommit() => this.key == "commit";
}
