import 'package:injectable/injectable.dart';

abstract class AuthRemoteDatasource {}

@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {}
