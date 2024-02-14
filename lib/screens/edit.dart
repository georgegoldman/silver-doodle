import 'package:flutter/material.dart';
import 'package:simple_blog_app/components/form_field.dart';
import 'package:simple_blog_app/graphql/queries_macros.dart';
import 'package:simple_blog_app/services/service.dart';

/// A page for editing a blog post.
///
/// The [EditPage] widget allows users to edit the title, subtitle, and body
/// content of a blog post. It displays text fields pre-filled with the initial
/// values of the blog post attributes. Users can modify these fields and submit
/// the changes using the "Post" button.
class EditPage extends StatefulWidget {
  /// The initial title of the blog post being edited.
  final String initialTitle;

  /// The initial subtitle of the blog post being edited.
  final String initialSubTitle;

  /// The initial body content of the blog post being edited.
  final String initialBody;

  /// The ID of the blog post being edited.
  final String id;

  /// Creates an [EditPage] widget.
  ///
  /// The [initialTitle], [initialSubTitle], and [initialBody] parameters represent
  /// the initial values of the title, subtitle, and body content of the blog post
  /// being edited, respectively. The [id] parameter specifies the unique identifier
  /// of the blog post.
  const EditPage({
    Key? key,
    required this.initialTitle,
    required this.initialSubTitle,
    required this.initialBody,
    required this.id,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with ApplicationFormField {
  late TextEditingController _titleController;
  late TextEditingController _subTitleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with initial values
    _titleController = TextEditingController(text: widget.initialTitle);
    _subTitleController = TextEditingController(text: widget.initialSubTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          // Text fields for editing title, subtitle, and body content
          applicationTextField(_titleController, 'Title'),
          applicationTextField(_subTitleController, 'Subtitle'),
          applicationTextArea(_bodyController, 'Body'),
          const SizedBox(height: 15),
          // Button to submit the updated blog post
          ElevatedButton(
            onPressed: () {
              // Update the blog post using ApplicationService
              ApplicationService applicationService =
                  ApplicationService(context);
              applicationService.updatePost(
                widget.id,
                _titleController.text,
                _subTitleController.text,
                _bodyController.text,
                updateQuery,
              );
            },
            child: const Text("Post"),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
