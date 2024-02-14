import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog_app/screens/blog_list.dart';
import 'package:simple_blog_app/utils/graphql_config.dart';

/// Entry point for the application.
///
/// Initializes the application and sets up the GraphQL client.
void main() async {
  // Initialize Hive for Flutter storage.
  await initHiveForFlutter();

  // Run the application.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      // Provide the GraphQL client configured with GraphQLConfig.
      client: GraphQLConfig.client,
      child: MaterialApp(
        title: 'Simple Blog Application',
        theme: ThemeData(
          // Set custom color scheme for the application.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // Enable Material 3 design.
          useMaterial3: true,
        ),
        // Set the initial route to the BlogList screen.
        home: const BlogList(),
      ),
    );
  }
}
