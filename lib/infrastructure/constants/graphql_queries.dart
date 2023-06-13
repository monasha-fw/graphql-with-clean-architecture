abstract class GraphQlQueries {
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
}
