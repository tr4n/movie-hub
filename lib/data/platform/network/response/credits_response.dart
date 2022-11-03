

import '../../../model/models.dart';

class CreditsResponse {
  int? id;
  List<Cast>? casts;
  List<Crew>? crews;

  CreditsResponse({this.id, this.casts, this.crews});

  CreditsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      casts = <Cast>[];
      json['cast'].forEach((v) {
        casts!.add(Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crews = <Crew>[];
      json['crew'].forEach((v) {
        crews!.add(Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (casts != null) {
      data['cast'] = casts!.map((v) => v.toJson()).toList();
    }
    if (crews != null) {
      data['crew'] = crews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
