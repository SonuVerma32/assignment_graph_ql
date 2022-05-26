import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

class ApiManager{
  final HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => "",
  );
  late Link link;
  late GraphQLClient client;

  ApiManager() {
    link = authLink.concat(httpLink);
    client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future getCountries() async {
    const String query = '''
        query Query {
  countries {
    code
    name
    phone
    currency
    languages {
      code
      name
      native
      rtl
    }
    emoji
    emojiU
    native
    continent {
      code
      name
    }
  }
}
  ''';
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    return jsonEncode(result.data);
  }
}