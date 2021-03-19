import 'package:comentowork/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Detail extends StatefulWidget {
  final String id;
  Detail({this.id});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _loading = true;

  int cid;

  String title;

  String contents;

  int categoryid;

  int userid;

  String createdat;

  String updatedat;

  String reply;

  String createdDateString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetail();
  }

  getdetail() async {
    DetailNews detailNews = DetailNews();
    var detaildata = await detailNews.getdetailNews(widget.id);
    cid = detaildata['data']['id'];
    title = detaildata['data']['title'];
    contents = detaildata['data']['contents'];
    categoryid = detaildata['data']['category_id'];
    userid = detaildata['data']['user_id'];
    createdat = detaildata['data']['created_at'];
    updatedat = detaildata['data']['updated_at'];
    reply = detaildata['reply'];

    DateTime createdDate = DateTime.parse(createdat);
    createdDateString = DateFormat.yMMMd('en_US').format(createdDate);

    DateTime updateDate = DateTime.parse(updatedat);
    String updateDateString = DateFormat.yMMMd('en_US').format(updateDate);
    print(createdDateString);
    

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DetailPage')),
      body: Center(
          child: _loading
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        child: ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 380,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('$categoryid'),
                                            Text('$cid'),
                                          ],
                                        ),
                                        Divider(
                                            thickness: 1, color: Colors.black),
                                        SizedBox(height: 5),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(createdDateString, style: TextStyle(),)),
                                        SizedBox(height: 15),
                                        Text(title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 15),
                                        Text(contents,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )),
                              );
                            }),
                      ),
                    ],
                  ),
                )),
    );
  }
}

// class DetailBodyTile extends StatelessWidget {
//   final String cid, title, contents, categoryid, userid, cratedat, updatedat;
//   DetailBodyTile({
//     this.cid,
//     this.title,
//     this.contents,
//     this.categoryid,
//     this.userid,
//     this.cratedat,
//     this.updatedat,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(right: 16, top: 5),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(categoryid),
//                 Text(cid),
//               ],
//             ),
//             Divider(thickness: 1, color: Colors.black),
//             SizedBox(height: 3),
//             Text(
//               title,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5),
//             Text(contents, maxLines: 1, overflow: TextOverflow.ellipsis),

//             // Text(cratedat),
//           ],
//         ));
//   }
// }
