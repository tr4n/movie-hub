import 'package:moviehub/data/model/author.dart';
import 'package:moviehub/data/model/models.dart';

class ReviewsResponse {
  int? id;
  int? page;
  List<Review>? results;
  int? totalPages;
  int? totalResults;

  ReviewsResponse(
      {this.id, this.page, this.results, this.totalPages, this.totalResults});

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    if (json['results'] != null) {
      results = <Review>[];
      json['results'].forEach((v) {
        results!.add(Review.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}



