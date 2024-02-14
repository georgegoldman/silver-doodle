// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog_app/graphql/queries_macros.dart';

class ApplicationService extends ChangeNotifier {
  final BuildContext context;

  // Constructor to initialize with BuildContext
  ApplicationService(this.context);

  // Method to check internet connection using the connectivity package
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  // Method to create a new blog post
  void createPost(
      String title, String subTitle, String body, String mutation) async {
    bool isConnected =
        await _checkInternetConnection(); // Check internet connection
    if (!isConnected) {
      // Show snackbar if no internet connection
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
      ));
      return;
    }
    // Make GraphQL mutation to create a blog post
    final result = await GraphQLProvider.of(context).value.mutate(
          MutationOptions(
              document: gql(mutation),
              variables: {'title': title, 'subTitle': subTitle, 'body': body}),
        );

    if (result.hasException) {
      // Show error snackbar if mutation fails
      final errorMessage =
          "Error creating blog post: ${result.exception.toString()}";
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('error in server')));
    } else {
      // Show success snackbar if mutation succeeds
      const successMessage = "Blog post created successfully!";
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(successMessage)));
      debugPrint(
          "Created blog post: ${result.data?['createBlog']['blogPost']}");
    }
  }

  // Method to delete a blog post
  void deletePost(String blogId, String mutation) async {
    bool isConnected =
        await _checkInternetConnection(); // Check internet connection
    if (!isConnected) {
      // Show snackbar if no internet connection
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
      ));
      return;
    }
    // Make GraphQL mutation to delete a blog post
    final result = await GraphQLProvider.of(context).value.mutate(
          MutationOptions(
              document: gql(mutation), variables: {'blogId': blogId}),
        );
    if (result.hasException) {
      // Show error snackbar if mutation fails
      final errorMessage =
          "Error deleting blog post: ${result.exception.toString()}";
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server error')));
    } else {
      // Show success snackbar if mutation succeeds
      const successMessage = "Blog post deleted successfully!";
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(successMessage)));
      debugPrint("Deleted blog post with ID: $blogId");
      Navigator.pop(context);
    }
  }

  // Method to get a specific blog post
  Future<Map<String, dynamic>?> getBlog(String? id) async {
    bool isConnected =
        await _checkInternetConnection(); // Check internet connection
    if (!isConnected) {
      // Show snackbar if no internet connection
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
      ));
      return null;
    }
    // Make GraphQL query to get a specific blog post
    final result = await GraphQLProvider.of(context).value.query(
        QueryOptions(document: gql(getQuery), variables: {'blogId': id}));

    if (result.hasException) {
      // Show error snackbar if query fails
      final errorMessage =
          "Error fetching blog post: ${result.exception.toString()}";
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server error')));
      return null;
    }

    return result.data?['blogPost'];
  }

  // Method to get all blog posts
  Future<List<Map<String, dynamic>>?> getAllBlog() async {
    bool isConnected =
        await _checkInternetConnection(); // Check internet connection
    if (!isConnected) {
      // Show snackbar if no internet connection
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
      ));
      return null;
    }
    // Make GraphQL query to get all blog posts
    final result = await GraphQLProvider.of(context)
        .value
        .query(QueryOptions(document: gql(getAllQuery)));

    if (result.hasException) {
      // Show error snackbar if query fails
      final errorMessage =
          "Error fetching blogs: ${result.exception.toString()}";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return null;
    }

    // Ensure that result.data?['allBlogPosts'] is List<Map<String, dynamic>>
    final List<dynamic>? allBlogPosts = result.data?['allBlogPosts'];

    if (allBlogPosts != null) {
      return allBlogPosts.cast<Map<String, dynamic>>();
    } else {
      return null;
    }
  }

  // Method to update a blog post
  void updatePost(String blogId, String title, String subTitle, String body,
      String mutation) async {
    bool isConnected =
        await _checkInternetConnection(); // Check internet connection
    if (!isConnected) {
      // Show snackbar if no internet connection
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No internet connection'),
      ));
      return;
    }
    // Make GraphQL mutation to update a blog post
    final result = await GraphQLProvider.of(context).value.mutate(
          MutationOptions(
            document: gql(mutation),
            variables: {
              'blogId': blogId,
              'title': title,
              'subTitle': subTitle,
              'body': body,
            },
          ),
        );

    if (result.hasException) {
      // Show error snackbar if mutation fails
      final errorMessage =
          "Error updating blog post: ${result.exception.toString()}";
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server error')));
    } else {
      // Show success snackbar if mutation succeeds
      const successMessage = "Blog post updated successfully!";
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(successMessage)));
      debugPrint("Updated blog post with ID: $blogId");
    }
  }
}
