/// Constants representing GraphQL queries used in the application.
///
/// These strings define GraphQL queries for various operations such as
/// deleting, updating, and fetching blog posts.
String deleteQuery = """
mutation deleteBlogPost(\$blogId: String!) {
  deleteBlog(blogId: \$blogId) {
    success
  }
}
""";

String updateQuery = """
mutation updateBlogPost(\$blogId: String!, \$title: String!, \$subTitle: String!, \$body: String!) {
  updateBlog(blogId: \$blogId, title: \$title, subTitle: \$subTitle, body: \$body) {
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

String getQuery = """
query getBlog(\$blogId: String!) {
  blogPost(blogId: \$blogId) {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";

String getAllQuery = """
query fetchAllBlogs {
  allBlogPosts {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";
