import '../../../../domain/entities/login_entity.dart';

class SearchArg {
  final LoginEntity loginEntity;
  final String searchKey;

  SearchArg(this.loginEntity, this.searchKey);
}
