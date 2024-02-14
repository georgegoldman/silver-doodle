import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_blog_app/models/blog.dart';
import 'package:simple_blog_app/screens/edit.dart';
import 'package:simple_blog_app/services/service.dart';
import 'package:simple_blog_app/components/shake_animation.dart';

/// A page for viewing details of a blog post.
///
/// The [ViewDetails] widget displays the details of a specific blog post,
/// including its title, subtitle, body content, and creation date. It allows
/// users to view the details of a selected blog post and provides an option
/// to edit the post by navigating to the edit page.
class ViewDetails extends StatefulWidget {
  /// The ID of the blog post to view.
  final String? blogId;

  /// Creates a [ViewDetails] widget.
  const ViewDetails({Key? key, this.blogId}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    String? id = widget.blogId;

    // GraphQL query for fetching details of a specific blog post
    const getRepository = """query getBlog(\$id: String!) {
  blogPost(blogId: \$id) {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";

    return FutureBuilder<Map<String, dynamic>?>(
      future: ApplicationService(context).getBlog(id),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No blog post found');
        } else {
          final Map<String, dynamic> data = snapshot.data!;
          final Blog blogPost = Blog.fromJson(data);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("View Blog"),
              actions: [
                // Animate the edit button using ShakeAnimation
                ShakeAnimation(
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(
                          initialTitle: blogPost.title,
                          initialSubTitle: blogPost.subTitle,
                          initialBody: blogPost.body,
                          id: blogPost.id,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              children: [
                ListTile(
                  title: Text(
                    blogPost.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(blogPost.subTitle),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(blogPost.body),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'created on ',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 11),
                        children: <TextSpan>[
                          TextSpan(
                            text: convertGraphQLDateToReadableDateTime(
                              blogPost.dateCreated.toString(),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  /// Converts GraphQL date format to readable date and time format.
  ///
  /// This function takes a string representation of a date in GraphQL format,
  /// parses it to a [DateTime] object, and then formats it to a human-readable
  /// date and time format.
  String convertGraphQLDateToReadableDateTime(String graphqlDate) {
    // Parse GraphQL date string to DateTime object
    DateTime dateTime = DateTime.parse(graphqlDate);

    // Format DateTime object to desired date and time format
    String formattedDateTime = DateFormat.yMMMMd().add_jm().format(dateTime);
    return formattedDateTime;
  }
}
