import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {

  final String id;
  Login({this.id});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  static final storage = FlutterSecureStorage();
  //데이터를 이전 페이지에서 전달 받은 정보를 저장하기 위한 변수
  String id;

  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Page'),),
      body: Center(child: Text(id),)
    );
  }
}