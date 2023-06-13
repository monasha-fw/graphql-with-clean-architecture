import 'package:graphql_demo/core/repositories/i_auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {}
