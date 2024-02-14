import 'package:flutter/material.dart';
import 'package:simple_blog_app/graphql/queries_macros.dart';
import 'package:simple_blog_app/services/service.dart';

/// A mixin providing a method for displaying a delete confirmation popup.
///
/// The [PopUps] mixin includes a [deletePopUp] method, which displays
/// an AlertDialog to confirm the deletion of a blog post.
mixin PopUps {
  /// Displays a delete confirmation popup.
  ///
  /// This method creates and shows an AlertDialog with a warning message
  /// and options to cancel or proceed with the deletion of a blog post.
  ///
  /// - [context]: The BuildContext where the popup should be displayed.
  /// - [blogId]: The ID of the blog post to be deleted.
  /// - [blogPostName]: The name of the blog post to be deleted.
  Future<dynamic> deletePopUp(
    BuildContext context,
    String blogId,
    String blogPostName,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("⚠️ Warning!"),
          content:
              Text("Are you sure you want to delete '$blogPostName' post?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Create an instance of ApplicationService
                ApplicationService applicationService =
                    ApplicationService(context);
                // Call the deletePost method to delete the blog post
                applicationService.deletePost(blogId, deleteQuery);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
