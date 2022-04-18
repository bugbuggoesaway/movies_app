// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:myapp/service/webservice.dart';

import 'movie.dart';

Pagination paginationFromJson(Uint8List bytes) =>
    Pagination.fromJson(json.decode(const Utf8Decoder().convert(bytes)));

String paginationToJson(Pagination data) => json.encode(data.toJson());

class Pagination {
  Pagination({
    required this.total,
    required this.hasNext,
    required this.data,
  });

  int total;
  bool hasNext;
  List<Movie> data;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        hasNext: json["has_next"],
        data: List<Movie>.from(json["data"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "has_next": hasNext,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  static Resource<Pagination> list(int page, int size) {
    return Resource(
        url: 'http://cafebabe.fun:8080/movies/?page=$page&size=$size',
        parse: (response) {
          return paginationFromJson(response.bodyBytes);
        });
  }
}
