import 'package:restoran/features/menu/domain/entities/menu.dart';
import 'package:restoran/features/menu/domain/repositories/menu_repository.dart';
import 'package:meta/meta.dart';

class GetMenu {
  final MenuRepository repository;

  GetMenu({@required this.repository});

  Future<Menu> call() async {
    return await repository.getMenu();
  }
}
