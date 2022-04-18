class Movie {
  Movie({
    required this.name,
    required this.chineseName,
    required this.coverUrl,
    required this.summary,
    required this.rating,
  });

  String name;
  String chineseName;
  String coverUrl;
  String summary;
  int rating;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        name: json["name"],
        chineseName: json["chinese_name"],
        coverUrl: json["cover_url"],
        summary: json["summary"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "chinese_name": chineseName,
        "cover_url": coverUrl,
        "summary": summary,
        "rating": rating,
      };
}
