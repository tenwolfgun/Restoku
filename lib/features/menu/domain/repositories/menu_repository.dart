import 'package:restoran/features/menu/domain/entities/menu.dart';

abstract class MenuRepository {
  Future<Menu> getMenu();
}
