class EducationModel {
  List<Education>? education;
  int? total;

  EducationModel({this.education, this.total});

  EducationModel.fromJson(Map<String, dynamic> json) {
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(Education.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Education {
  int? id;
  String? title;

  Education({this.id, this.title});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
