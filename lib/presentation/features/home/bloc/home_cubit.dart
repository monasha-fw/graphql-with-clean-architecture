import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_demo/core/entities/characters/character.dart';
import 'package:graphql_demo/core/options/get_pagination.dart';
import 'package:graphql_demo/core/usecases/characters/get_all_characters.dart';
import 'package:graphql_demo/presentation/extensions/failure.dart';
import 'package:injectable/injectable.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllCharacters _getAllCharacters;

  HomeCubit(this._getAllCharacters) : super(HomeState.initial());

  void getAllCharacters() async {
    emit(state.copyWith(processing: true));

    const pagination = GetPagination(page: 1);
    final characters = await _getAllCharacters(pagination);

    Either<String, List<Character>> errOrResult = characters.fold(
      (f) => Left(f.getMessage),
      (result) => Right(result),
    );
    emit(state.copyWith(processing: false, characters: optionOf(errOrResult)));
  }
}
