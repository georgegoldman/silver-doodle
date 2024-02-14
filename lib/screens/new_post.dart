import 'package:flutter/material.dart';
import 'package:simple_blog_app/components/form_field.dart';
import 'package:simple_blog_app/services/service.dart';

/// A page for creating a new blog post.
///
/// The [NewPost] widget allows users to create a new blog post by providing
/// a title, subtitle, and body content. It includes text fields for entering
/// these details and a button to submit the new post. Upon submission, the
/// post is created using the specified GraphQL mutation query.
class NewPost extends StatefulWidget {
  /// Creates a [NewPost] widget.
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with ApplicationFormField {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // GraphQL mutation query for creating a new blog post
  final String createRepository = """
    mutation createBlogPost(\$title: String!, \$subTitle: String!, \$body: String!) {
  createBlog(title: \$title, subTitle: \$subTitle, body: \$body) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
    }
  }
}
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Blog Post'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          // Text fields for entering title, subtitle, and body content
          applicationTextField(_titleController, 'Title'),
          const SizedBox(height: 8),
          applicationTextField(_subTitleController, 'Subtitle'),
          const SizedBox(height: 8),
          applicationTextArea(_bodyController, 'Body'),
          const SizedBox(height: 15),
          // Button to submit the new blog post
          ElevatedButton(
            onPressed: () {
              // Retrieve text input from text controllers
              String title = _titleController.text;
              String subTitle = _subTitleController.text;
              String body = _bodyController.text;
              // Create new post using ApplicationService
              ApplicationService applicationService =
                  ApplicationService(context);
              applicationService.createPost(
                title,
                subTitle,
                body,
                createRepository,
              );
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }
}
