import 'package:moviehub/data/model/author.dart';

import '../platform/network/api/urls.dart';

class Review {
  String? author;
  Author? authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  Review(
      {this.author,
        this.authorDetails,
        this.content,
        this.createdAt,
        this.id,
        this.updatedAt,
        this.url});

  Review.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    authorDetails = json['author_details'] != null
        ? Author.fromJson(json['author_details'])
        : null;
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    if (authorDetails != null) {
      data['author_details'] = authorDetails!.toJson();
    }
    data['content'] = content;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    return data;
  }

  String getAvatarAuthorUrl() {
    final path = authorDetails?.avatarPath;
    if (path == null) {
      return "https://api.lorem.space/image/face?w=44&h=44";
    }
    if (path.contains("https")) {
      return path.substring(1);
    }
    return "${Urls.w342ImagePath}$path";
  }

  String getAuthorName() {
    final name = authorDetails?.name ?? "";
    return name.isNotEmpty ? name : "Anonymous";
  }
}
