import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Configuration class for GraphQL client setup.
class GraphQLConfig {
  /// The HTTP link for GraphQL endpoint.
  static HttpLink httpLink = HttpLink('https://uat-api.vmodel.app/graphql/');

  /// Value notifier for GraphQL client.
  ///
  /// Initializes a [GraphQLClient] with the HTTP link and cache.
  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())),
  );
}
