/// A class representing a blog post.
///
/// The [Blog] class defines properties for various attributes of a blog post,
/// such as its ID, title, subtitle, body, and creation date.
class Blog {
  /// The unique identifier of the blog post.
  final String id;

  /// The title of the blog post.
  final String title;

  /// The subtitle of the blog post.
  final String subTitle;

  /// The body content of the blog post.
  final String body;

  /// The date when the blog post was created.
  final DateTime dateCreated;

  /// Constructs a [Blog] instance with the provided attributes.
  ///
  /// All parameters are required to create a [Blog] object.
  Blog({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.body,
    required this.dateCreated,
  });

  /// Creates a [Blog] instance from a JSON map.
  ///
  /// The [json] parameter contains the data parsed from a JSON response.
  /// This factory method constructs a [Blog] object by extracting values
  /// from the JSON map.
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      body: json['body'],
      dateCreated: DateTime.parse(json['dateCreated']),
    );
  }
}
