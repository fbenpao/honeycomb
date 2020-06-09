import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/config/ignoreConfig.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/net/address.dart';
import 'package:gsy_github_app_flutter/common/net/api.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/redux/login_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/animated_background.dart';
import 'package:gsy_github_app_flutter/widget/gsy_flex_button.dart';
import 'package:gsy_github_app_flutter/widget/gsy_input_widget.dart';
import 'package:gsy_github_app_flutter/widget/particle/particle_widget.dart';

/**
 * 登录页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  bool _isClick = false;
  int sex = 1;
  @override
  Widget build(BuildContext context) {
    /// 触摸收起键盘
    /// GestureDetector 手势控制点击组件
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('ostrich'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //测试vpn是否可用
            if(isVpnActive() != null){
              print("VPN可用");
              print(isVpnActive());
            }
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.cloud_download,color: Colors.red,),
        ),
        drawer: Drawer(child: ListView(
          // 干掉顶部灰色区域
//          padding: EdgeInsets.all(10),
          // 所有抽屉中的子组件都定义到这里：
          children: <Widget>[
            ListTile(
              title: Text('升级到会员'),
              trailing: Icon(Icons.send),
            ),
            Divider(),
            ListTile(
              title: Text('设置'),
              trailing: Icon(Icons.settings),
            ),
            Divider(),
            ListTile(
              title: Text('注销'),
              trailing: Icon(Icons.exit_to_app),
            )
          ],
        )),
        body: new Container(
          color:Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Container(
                    width: double.infinity,
                    height: 120,
//                    color: Color(0xFF00FF00),
                    padding: new EdgeInsets.all(30.0),
                    child: Text(
                      "OSTRICH",
                      style: TextStyle(fontSize: 40.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
               new Column(
                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     width: double.infinity,
//                     color: Colors.red,
                     height: 400,
                     child: new IconButton(
                       icon:(_isClick?Icon(Icons.signal_wifi_4_bar,color:Colors.green,size: 180):Icon(Icons.signal_wifi_off,color:Colors.black38,size: 180)) ,
                       tooltip: '点击连接外网',
                       onPressed: () {
                         getData();
                         // ...
                       },
                     ),
                   ),
                   Container(
//                     width: double.infinity,
                     padding: new EdgeInsets.all(20.0),
                     child:(
                         RaisedButton(
                           child: Text('切换地区'),
                           onPressed: () {
                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return AlertDialog(
                                     title: Text('选择服务器地址'),
//                                     content: new ListView(children:list),
                                     content: new StatefulBuilder(builder: (context, StateSetter setState) {
                                     return Container(width: 450, height: 400, child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                   new ListTile(
                                   title: new Text('美国',
                                   style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                   ),
                                   subtitle: new Text("127.0.0.1"),
                                   leading: new Icon(Icons.cloud,color: Colors.blue[500]),
                                   ),
                                   Divider(height: 0.5,indent: 60.0,color: Colors.blue,),
                                   new ListTile(
                                   title: new Text("日本",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                                   subtitle: new Text("127.0.0.1"),
                                   leading: new Icon(Icons.airplanemode_active,color: Colors.blue[500])
                                   ),
                                   Divider(height: 0.5,indent: 60.0,color: Colors.blue,),
                                   new ListTile(
                                   title: new Text('新加披',
                                   style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                   ),
                                   subtitle: new Text("127.0.0.1"),
                                   leading: new Icon(Icons.vpn_key,color: Colors.blue[500]),
                                   ),
                                   Divider(height: 0.5,indent: 60.0,color: Colors.blue,),
                                   RadioListTile(
                                   value: 1,
                                   onChanged: (value) {
                                   setState(() {
                                   this.sex = value;
                                   });
                                   },
                                   secondary: Icon(Icons.camera),
                                   title: Text("一级标题"),
                                   subtitle: Text("二级标题"),
                                   groupValue: this.sex,
                                   selected: this.sex == 1,
                                   ),
                                   RadioListTile(
                                   value: 2,
                                   onChanged: (value) {
                                   setState(() {
                                   this.sex = value;
                                   });
                                   },
                                   secondary: Icon(Icons.camera),
                                   title: Text("一级标题"),
                                   subtitle: Text("二级标题"),
                                   groupValue: this.sex,
                                   selected: this.sex == 2,
                                   ),
                                   ],
                                   ),
                                   ),
                                   )
                                 });
                           },
                         )
                   )),
                   Container(
                     width: double.infinity,
                     padding: new EdgeInsets.all(20.0),
                     child:(_isClick?Text(
                       "已连接，点击断开连接",
                       style: TextStyle(fontSize: 20.0),
                       textAlign: TextAlign.center,
                     ):Text(
                       "已断开，请点击重连",
                       style: TextStyle(fontSize: 20.0),
                       textAlign: TextAlign.center,
                     )),
                   ),
                 ]
               )

            ],
          ),
//          child: Stack(children: <Widget>[
//            Positioned.fill(child: AnimatedBackground()),
//            Positioned.fill(child: ParticlesWidget(30)),
//           child: new Center(
//              child:new IconButton(
//                icon: Icon(Icons.signal_wifi_4_bar,color:Colors.green,size: 120),
//                        tooltip: '点击连接外网',
//                        onPressed: () {
//                          // ...
//                        },
//              ),
//                child: new Column(
////                    mainAxisAlignment:MainAxisAlignment.center,
//                    children: <Widget>[
//                      new IconButton(
//                        icon: Icon(Icons.signal_wifi_4_bar,color:Colors.green,size: 80),
//                        tooltip: 'Increase volume by 10%',
//                        onPressed: () {
//                          // ...
//                        },
//                      ),
//                      Text("一键连接外网",style: TextStyle(fontSize: 12)),
//                    ]
//                )
//              child:Icon(Icons.signal_wifi_4_bar,color:Colors.green,size: 80),

//              ///防止overFlow的现象
//              child: SafeArea(
//                ///同时弹出键盘不遮挡
//                child: SingleChildScrollView(
//                  child: new Card(
//                    elevation: 5.0,
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                    color: GSYColors.cardWhite,
//                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
//                    child: new Padding(
//                      padding: new EdgeInsets.only(
//                          left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
//                      child: new Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          new Image(
//                              image: new AssetImage(GSYICons.DEFAULT_USER_ICON),
//                              width: 90.0,
//                              height: 90.0),
//                          new Padding(padding: new EdgeInsets.all(10.0)),
//                          new GSYInputWidget(
//                            hintText: GSYLocalizations.i18n(context)
//                                .login_username_hint_text,
//                            iconData: GSYICons.LOGIN_USER,
//                            onChanged: (String value) {
//                              _userName = value;
//                            },
//                            controller: userController,
//                          ),
//                          new Padding(padding: new EdgeInsets.all(10.0)),
//                          new GSYInputWidget(
//                            hintText: GSYLocalizations.i18n(context)
//                                .login_password_hint_text,
//                            iconData: GSYICons.LOGIN_PW,
//                            obscureText: true,
//                            onChanged: (String value) {
//                              _password = value;
//                            },
//                            controller: pwController,
//                          ),
//                          new Padding(padding: new EdgeInsets.all(10.0)),
//                          Container(
//                            height: 50,
//                            child: Row(
//                              children: <Widget>[
//                                new Expanded(
//                                  child: new GSYFlexButton(
//                                    text: GSYLocalizations.i18n(context)
//                                        .login_text,
//                                    color: Theme.of(context).primaryColor,
//                                    textColor: GSYColors.textWhite,
//                                    fontSize: 16,
//                                    onPress: loginIn,
//                                  ),
//                                ),
//                                new SizedBox(
//                                  width: 10,
//                                ),
//                                new Expanded(
//                                  child: new GSYFlexButton(
//                                    text: GSYLocalizations.i18n(context)
//                                        .oauth_text,
//                                    color: Theme.of(context).primaryColor,
//                                    textColor: GSYColors.textWhite,
//                                    fontSize: 16,
//                                    onPress: oauthLogin,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          new Padding(padding: new EdgeInsets.all(15.0)),
//                          InkWell(
//                            onTap: () {
//                              CommonUtils.showLanguageDialog(context);
//                            },
//                            child: Text(
//                              GSYLocalizations.i18n(context).switch_language,
//                              style: TextStyle(color: GSYColors.subTextColor),
//                            ),
//                          ),
//                          new Padding(padding: new EdgeInsets.all(15.0)),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            )
//          ]),
        ),
      ),
    );
  }
  List<Widget> list = <Widget>[
    new ListTile(
      title: new Text('美国',
        style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
      ),
      subtitle: new Text("127.0.0.1"),
      leading: new Icon(Icons.cloud,color: Colors.blue[500]),
    ),
    new ListTile(
        title: new Text("日本",style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
        subtitle: new Text("127.0.0.1"),
        leading: new Icon(Icons.airplanemode_active,color: Colors.blue[500])
    ),
    new ListTile(
      title: new Text('新加披',
        style: new TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
      ),
      subtitle: new Text("127.0.0.1"),
      leading: new Icon(Icons.vpn_key,color: Colors.blue[500]),
    ),
  ];

  getData() async{
    setState(() {
      if(_isClick){
        _isClick = false;
      }else{
        _isClick = true;
      }
    });
    HttpManager httpManager = new HttpManager();
    print("获取的结果----"+_isClick.toString());
    print(httpManager.netFetch("https://www.baidu.com", null, null, null));
  }


    Future<bool> isVpnActive() async {
      bool isVpnActive;
      List<NetworkInterface> interfaces = await NetworkInterface.list(
          includeLoopback: false, type: InternetAddressType.any);
      interfaces.isNotEmpty
          ? isVpnActive = interfaces.any((interface) =>
      interface.name.contains("tun") ||
          interface.name.contains("ppp") ||
          interface.name.contains("pptp"))
          : isVpnActive = false;
      return isVpnActive;
    }
}

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController userController = new TextEditingController();

  final TextEditingController pwController = new TextEditingController();

  var _userName = "";

  var _password = "";

  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_usernameChange);
    pwController.removeListener(_passwordChange);
  }

  _usernameChange() {
    _userName = userController.text;
  }

  _passwordChange() {
    _password = pwController.text;
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  loginIn() async {
    if (_userName == null || _userName.isEmpty) {
      return;
    }
    if (_password == null || _password.isEmpty) {
      return;
    }

    ///通过 redux 去执行登陆流程
    StoreProvider.of<GSYState>(context)
        .dispatch(LoginAction(context, _userName, _password));
  }



  oauthLogin() async {
    String code = await NavigatorUtils.goLoginWebView(context,
        Address.getOAuthUrl(), "${GSYLocalizations.i18n(context).oauth_text}");

    if (code != null && code.length > 0) {
      ///通过 redux 去执行登陆流程
      StoreProvider.of<GSYState>(context).dispatch(OAuthAction(context, code));
    }
  }
}
