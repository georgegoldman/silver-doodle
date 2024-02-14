import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog_app/screens/new_post.dart';
import 'package:simple_blog_app/components/popup_delete.dart';
import 'package:simple_blog_app/screens/view_details.dart';

/// A widget for displaying a list of blog posts.
///
/// The [BlogList] widget fetches and displays a list of blog posts using a GraphQL query.
/// It includes options to view details of each post, delete posts, and create new posts.
class BlogList extends StatefulWidget {
  /// Creates a [BlogList] widget.
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> with PopUps {
  // GraphQL query to fetch all blog posts
  final String readRepository = """ query fetchAllBlogs {
  allBlogPosts {
    id
    title
    subTitle  
    body
    dateCreated
  }
}
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Posts'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(readRepository),
          pollInterval: const Duration(seconds: 5),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            // Handle exception if any
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            // Handle loading state
            return const Text('loading');
          }

          List? repositories = result.data?['allBlogPosts'];
          if (repositories == null) {
            // Handle when there are no blog posts
            return const Text('No blog');
          }
          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewDetails(
                          blogId: repository['id'],
                        ),
                      ),
                    ),
                    title: Text(repository['title'] ?? ''),
                    subtitle: Text(repository['subTitle'] ?? ''),
                    trailing: IconButton(
                      onPressed: () => deletePopUp(
                        context,
                        repository['id'],
                        repository['title'],
                      ),
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewPost()),
        ),
        child: const Icon(Icons.create),
      ),
    );
  }
}
