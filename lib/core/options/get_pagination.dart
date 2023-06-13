import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_pagination.freezed.dart';

@freezed
class GetPagination with _$GetPagination {
  const factory GetPagination({
    @Default(1) int page,
  }) = _GetPagination;
}
