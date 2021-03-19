import 'package:comentowork/data/categorydata.dart';
import 'package:comentowork/model/bodymodel.dart';
import 'package:comentowork/model/menu.dart';
import 'package:comentowork/repository/repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:comentowork/model/menu.dart';

import 'categoryNews.dart';
import 'detailpage.dart';


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

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //widget.id는 LogOutPage에서 전달받은 id를 의미한다.
    categories = getCategories();
    getBody();
  }

  getBody() async {
    BodyContent bodyContent = BodyContent();
    await bodyContent.getNews();
    bodyModel = bodyContent.news;
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
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CatgoryTile(
                            categoryName: categories[index].categoryName,
                            cuserid: categories[index].cuserid
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
                          return BodyTile(
                            title: bodyModel[index].title,
                            contents: bodyModel[index].contents,
                            userid: bodyModel[index].userid.toString(),
                            bodyid: bodyModel[index].bodyid.toString(),
                            categoryid: bodyModel[index].categoryid.toString()
                          );
                        }),
                  )
                ],
              )),
            ),
    );
  }
}

class CatgoryTile extends StatelessWidget {
  final categoryName;
  final cuserid;
  CatgoryTile({this.categoryName, this.cuserid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Categorynews(cuserid: cuserid)));
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
                categoryName,
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
  final String title, contents, categoryid, userid, cratedat, updatedat, bodyid;
  BodyTile(
      {this.title,
      this.contents,
      this.categoryid,
      this.userid,
      this.cratedat,
      this.updatedat,
      this.bodyid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(id: bodyid)));
      },
      child: Container(
          margin: EdgeInsets.only(right: 16, top: 5),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(categoryid),
                  Text(bodyid),
                ],
              ),
              Divider(thickness: 1, color: Colors.black),
              SizedBox(height: 3),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(contents, maxLines: 1, overflow: TextOverflow.ellipsis),

              // Text(cratedat),
            ],
          )),
    );
  }
}
