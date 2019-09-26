import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_keyboard/vehicle_keyboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: SecondScreen(),
    );
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  bool showKeyboard = false;

  TextEditingController controller = new TextEditingController();


  /// 键盘的整体回调，根据不同的按钮事件来进行相应的逻辑实现
  void _onKeyDown(KeyDownEvent data) {
    debugPrint("keyEvent:" + data.key);

    if (data.isClose() || data.isCommit()) {
      setState(() {
        showKeyboard = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸)
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('车牌键盘'),
        backgroundColor: Colors.lightBlue,
      ),
      body: new Center(
          child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: '请输入车牌',
            ),
            controller: controller,
            focusNode: FocusNode(canRequestFocus: false),
            onTap: () {
              setState(() {
                showKeyboard = true;
              });
            },
          ),
          RaisedButton(
            child: Text("隐藏/显示"),
            onPressed: () {
              setState(() {
                showKeyboard = !showKeyboard;
              });
            },
          )
        ],
      )),
      bottomNavigationBar: showKeyboard ? VehicleKeyboard(_onKeyDown,controller) : null,
    );
  }
}
