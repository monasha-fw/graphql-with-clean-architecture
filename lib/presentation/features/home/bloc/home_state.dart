part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required int page,
    required bool processing,
    required Option<Either<String, List<Character>>> characters,
  }) = _Initial;

  factory HomeState.initial() => HomeState(
        page: 1,
        processing: false,
        characters: none(),
      );
}
