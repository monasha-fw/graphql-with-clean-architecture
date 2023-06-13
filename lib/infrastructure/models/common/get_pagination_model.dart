import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart' as graph;
import 'package:graphql_demo/core/options/get_pagination.dart';

part 'get_pagination_model.freezed.dart';
part 'get_pagination_model.g.dart';

@freezed
class GetPaginationModel with _$GetPaginationModel {
  const GetPaginationModel._();

  const factory GetPaginationModel({
    @Default(1) int page,
  }) = _GetPaginationModel;

  factory GetPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$GetPaginationModelFromJson(json);

  factory GetPaginationModel.fromDomain(GetPagination pagination) {
    return GetPaginationModel(page: pagination.page);
  }

  graph.QueryOptions toQueryOptions(String document) {
    return graph.QueryOptions(
      document: graph.gql(document),
      variables: <String, dynamic>{'page': page},
    );
  }
}
