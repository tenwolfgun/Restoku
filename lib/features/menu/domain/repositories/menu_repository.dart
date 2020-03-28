import '../entities/menu.dart';

abstract class MenuRepository {
  Future<Menu> getMenu();
}
