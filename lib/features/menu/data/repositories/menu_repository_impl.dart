import 'package:meta/meta.dart';

import '../../domain/entities/menu.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_data_source.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuDataSource dataSource;

  MenuRepositoryImpl({@required this.dataSource});

  @override
  Future<Menu> getMenu() async {
    return await dataSource.getMenu();
  }
}
