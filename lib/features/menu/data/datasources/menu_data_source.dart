import 'package:restoran/core/utils/utils.dart';
import 'package:restoran/features/menu/data/models/menu_model.dart';
import 'package:meta/meta.dart';

abstract class MenuDataSource {
  Future<MenuModel> getMenu();
}

class MenuDataSourceImple implements MenuDataSource {
  final Utils utils;
  MenuDataSourceImple({@required this.utils});

  @override
  Future<MenuModel> getMenu() async {
    try {
      final result = await utils.loadAsset();
      return menuFromJson(result);
    } on Exception catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
