import 'dart:convert';

import 'package:comentowork/model/adsmodel.dart';
import 'package:comentowork/model/bodymodel.dart';
import 'package:comentowork/model/detailmodel.dart';
import 'package:comentowork/model/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:io';



class BodyContent {
  List<BodyModel> news = [];

  Future<void> getNews(limititem) async {
    String url =
        "https://problem.comento.kr/api/list?page=0&ord=desc&category[]=1&limit=$limititem";

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
            createdat: element['created_at'],
            updatedat: element['updated_at'],
          );
          news.add(bodyModel);
        });
      }
    } else {
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}

class CategoryNews {
  List<BodyModel> news = [];

  Future<void> getcategoriNews(String category) async {
    String url =
        "https://problem.comento.kr/api/list?page=0&ord=desc&category[]=$category&limit=100";

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
            createdat: element['created_at'],
            updatedat: element['updated_at'],
          );
          news.add(bodyModel);
        });
      }
    } else {
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}

class DetailNews {
  Future<dynamic> getdetailNews(String bodyid) async {
    String url = "https://problem.comento.kr/api/view?id=$bodyid";
    var response = await http.get(url, headers: {"Accept": "application/json"});

    // print(jsonData);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}

class Adsnews {
  List<AdsModel> adsnews = [];

  Future<void> getcategoriNews() async {
    String url = "https://problem.comento.kr/api/ads?page=1&limit=100";

    var response = await http.get(url, headers: {"Accept": "application/json"});

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonData["data"] != null) {
        jsonData["data"].forEach((element) {
          AdsModel adsmodel = AdsModel(
            adsid: element['id'].toInt(),
            title: element['title'],
            contents: element['contents'],
            img: element['img'],
            createdat: element['created_at'],
            updatedat: element['updated_at'],
          );
          adsnews.add(adsmodel);
        });
      }
    } else {
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}

class CtgrMenu {
  List<CategoryModel> ctnews = [];

  Future<void> ctgrMenutab() async {
    String url = "https://problem.comento.kr/api/category";

    var response = await http.get(url, headers: {"Accept": "application/json"});

    var jsonData = jsonDecode(response.body);

    print(jsonData);

    if (response.statusCode == 200) {
      if (jsonData["category"] != null) {
        jsonData["category"].forEach((element) {
         CategoryModel ctnmodel = CategoryModel(
            ctgrid: element['id'].toInt(),
            ctgrname: element['name'],
          );
          ctnews.add(ctnmodel);
        });
      }
    } else {
      throw Exception('정보를 받아오는데 실패했습니다');
    }
  }
}