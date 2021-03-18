import 'dart:convert';

import 'package:comentowork/model/bodymodel.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class BodyContent {
  List<BodyModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://problem.comento.kr/api/list?page=0&ord=desc&category[]=1&limit=10";

    var response = await http.get(url, headers: {"Accept": "application/json"});

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonData["data"] != null) {
        jsonData["data"].forEach((element) {
          BodyModel bodyModel = BodyModel(
            title: element['title'],
            contents: element['contents'],
            categoryid: element['category_id'].toInt(),
            userid: element['user_id'].toInt(),
            bodyid: element['id'].toInt(),
            
          );
          news.add(bodyModel);
          print(news);
        });
      }
    }
    else{
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}
