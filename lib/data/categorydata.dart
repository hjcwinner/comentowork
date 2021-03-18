import 'package:comentowork/model/menu.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category = List<CategoryModel>();
  CategoryModel categoryModel = CategoryModel();
  

  //1
  
  categoryModel.categoryName = "apple";
  categoryModel.cuserid = "1";
  category.add(categoryModel);

  categoryModel = CategoryModel();

  //2
  
  categoryModel.categoryName = "banana";
  categoryModel.cuserid = "2";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  //3
  
  categoryModel.categoryName = "coconut";
  categoryModel.cuserid = "3";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  return category;
}