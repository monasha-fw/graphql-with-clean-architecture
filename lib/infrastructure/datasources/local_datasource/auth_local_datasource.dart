import 'package:injectable/injectable.dart';

abstract class AuthLocalDatasource {}

@Singleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {}
