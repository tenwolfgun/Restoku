import 'package:restoran/features/menu/data/datasources/menu_data_source.dart';
import 'package:restoran/features/menu/domain/entities/menu.dart';
import 'package:restoran/features/menu/domain/repositories/menu_repository.dart';
import 'package:meta/meta.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuDataSource dataSource;

  MenuRepositoryImpl({@required this.dataSource});

  @override
  Future<Menu> getMenu() async {
    return await dataSource.getMenu();
  }
}
