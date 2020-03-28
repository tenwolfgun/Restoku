import 'package:meta/meta.dart';

import '../entities/menu.dart';
import '../repositories/menu_repository.dart';

class GetMenu {
  final MenuRepository repository;

  GetMenu({@required this.repository});

  Future<Menu> call() async {
    return await repository.getMenu();
  }
}
