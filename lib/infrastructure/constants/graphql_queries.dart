abstract class GraphQlQueries {
  /// Queries
  static const String getAllCharactersQuery = r'''
  query GetAllCharactersQuery($page: Int) {
    characters(page: $page) {
      info {
        count
        next
        pages
        prev
      }
      results {
        id
        image
        name
      }
    }
  }
''';

  /// Mutations
  static const String addCharacter = r'''
  mutation AddStar($starrableId: ID!) {
    action: addStar(input: {starrableId: $starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
''';
}
