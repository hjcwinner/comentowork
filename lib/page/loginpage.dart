import 'package:comentowork/model/adsmodel.dart';
import 'package:comentowork/model/bodymodel.dart';
import 'package:comentowork/model/menu.dart';
import 'package:comentowork/repository/repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:comentowork/model/menu.dart';

import 'categoryNews.dart';
import 'detailpage.dart';
import 'package:intl/intl.dart';

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

  List<CategoryModel> categories = List<CategoryModel>();
  List<BodyModel> bodyModel = List<BodyModel>();
  List<AdsModel> adsModel = List<AdsModel>();
  List<CategoryModel> ctgrModel = List<CategoryModel>();

  bool _loading = true;

  int limititem = 100;

  int pagenum = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
    getBody();
    adsBody();
    ctgrBody();
  }

  getBody() async {
    BodyContent bodyContent = BodyContent();
    await bodyContent.getNews(limititem);
    bodyModel = bodyContent.news;
    setState(() {
      _loading = false;
    });
  }

  adsBody() async {
    Adsnews adsnews = Adsnews();
    await adsnews.getcategoriNews();
    adsModel = adsnews.adsnews;
    setState(() {
      _loading = false;
    });
  }

  ctgrBody() async {
    CtgrMenu ctgrMenu = CtgrMenu();
    await ctgrMenu.ctgrMenutab();
    ctgrModel = ctgrMenu.ctnews;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  child: Column(
                children: [
                  // Categories
                  Container(
                    height: 70,
                    child: ListView.builder(
                        itemCount: ctgrModel.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CatgoryTile(
                              ctgrid: ctgrModel[index].ctgrid,
                              ctgrname: ctgrModel[index].ctgrname
                              );
                        }),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        id + "님 안녕하세요",
                        style: TextStyle(fontSize: 30),
                      )),
                  // BodyContent
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount: bodyModel.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index % 4 == 0 && index != 0) {
                            return AdsTile(
                              adsid: adsModel[index~/4].adsid.toString(),
                              title: adsModel[index~/4].title,
                              contents: adsModel[index~/4].contents,
                              img: adsModel[index~/4].img,
                              createdat: adsModel[index~/4].createdat,
                              updatedat: adsModel[index~/4].updatedat,
                            );
                          } else {
                            return BodyTile(
                              title: bodyModel[index].title,
                              contents: bodyModel[index].contents,
                              userid: bodyModel[index].userid.toString(),
                              bodyid: bodyModel[index].bodyid.toString(),
                              categoryid:
                                  bodyModel[index].categoryid.toString(),
                              createdat: bodyModel[index].createdat,
                              updatedat: bodyModel[index].updatedat,
                            );
                          }
                        }),
                  )
                ],
              )),
            ),
    );
  }
}

class CatgoryTile extends StatelessWidget {
  final ctgrid;
  final ctgrname;
  CatgoryTile({this.ctgrid, this.ctgrname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorynews(ctgrid: ctgrid, ctgrname: ctgrname)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16, top: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.black,
                height: 60,
                width: 112,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 112,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                ctgrname,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BodyTile extends StatelessWidget {
  String createdDateString;
  String chancateid;

  final String title,
      contents,
      categoryid,
      userid,
      createdat,
      updatedat,
      bodyid;
  BodyTile(
      {this.title,
      this.contents,
      this.categoryid,
      this.userid,
      this.createdat,
      this.updatedat,
      this.bodyid});

  @override
  Widget build(BuildContext context) {
    DateTime createdDate = DateTime.parse(createdat);
    createdDateString = DateFormat.yMMMd('en_US').format(createdDate);

    if (categoryid == "1") {
      chancateid = "apple";
    } else if (categoryid == "2") {
      chancateid = "banana";
    } else if (categoryid == "3") {
      chancateid = "coconut";
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detail(id: bodyid)));
      },
      child: Container(
          margin: EdgeInsets.only(right: 16, top: 5),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Container(
            height: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(chancateid),
                    Text(bodyid),
                  ],
                ),
                Divider(thickness: 1, color: Colors.black),
                SizedBox(height: 3),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(createdDateString)),
                SizedBox(height: 18),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(contents, maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
          )),
    );
  }
}

class AdsTile extends StatelessWidget {
  String createdDateString;
  String chancateid;

  String title, contents, img, createdat, updatedat, adsid;
  AdsTile(
      {this.adsid,
      this.title,
      this.contents,
      this.img,
      this.createdat,
      this.updatedat});

  @override
  Widget build(BuildContext context) {
    DateTime createdDate = DateTime.parse(createdat);
    createdDateString = DateFormat.yMMMd('en_US').format(createdDate);
    return Container(
        margin: EdgeInsets.only(right: 16, top: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Container(
          height: 145,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(adsid),
              SizedBox(height: 5),
              Row(children: [
                Container(
                  height: 124,
                  width: 155,
                  child: Image.network('https://cdn.comento.kr/assignment/$img',
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        contents,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
