import 'package:comentowork/page/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController logid;

  String userInfo = ""; //user의 정보를 저장하기 위한 변수
  static final storage =
      new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logid = TextEditingController();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => Login(
                    id: userInfo,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 485,
              margin: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/head-1556569_1920.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(width: 95),
                Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.orangeAccent),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Form(
                    child: Theme(
                      data: ThemeData(
                          primaryColor: Colors.grey[800],
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Colors.black, fontSize: 18))),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.perm_identity, size: 35),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                                controller: logid,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    hintText: '아이디를 입력하세요'),
                                keyboardType: TextInputType.text,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ButtonTheme(
                    minWidth: 100,
                    height: 50,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        color: Colors.green,
                        onPressed: () async {
                          await storage.write(
                              key: "login",
                              value: logid.text.toString());
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Login(
                                      id: logid.text,
                                    )),
                          );
                        },
                        child: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 35)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
