class ReviewModel {
  final String id;
  final String author;
  final int rating;
  final String date;
  final String comment;

  const ReviewModel({
    required this.id,
    required this.author,
    required this.rating,
    required this.date,
    required this.comment,
  });
}
