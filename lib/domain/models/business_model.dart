class BusinessModel {
  String? businessName;
  String? ownerName;
  String? mobile;
  String? email;
  String? logo;
  String? sehrCode;
  String? lat;
  String? lon;
  String? about;
  String? address;
  String? tehsil;
  String? district;
  String? division;
  String? province;
  String? city;
  String? country;
  User? user;
  Grade? grade;
  Category? category;
  String? verifiedAt;
  int? id;
  String? createdAt;
  String? updatedAt;
  double? distance;
  bool? isFavourite = false;

  BusinessModel({
    this.businessName,
    this.ownerName,
    this.mobile,
    this.email,
    this.logo,
    this.sehrCode,
    this.lat,
    this.lon,
    this.about,
    this.address,
    this.tehsil,
    this.district,
    this.division,
    this.province,
    this.city,
    this.country,
    this.user,
    this.grade,
    this.category,
    this.verifiedAt,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.distance,
    this.isFavourite,
  });

  BusinessModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    mobile = json['mobile'];
    email = json['email'];
    logo = json['logo'];
    sehrCode = json['sehrCode'];

    lat = json['lat'];
    lon = json['lon'];
    about = json['about'];
    address = json['address'];
    tehsil = json['tehsil'];

    district = json['district'];
    division = json['division'];
    province = json['province'];
    city = json['city'];
    country = json['country'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    grade = json['grade'] != null ? Grade.fromJson(json['grade']) : null;

    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    verifiedAt = json['verifiedAt'];
    id = json['id'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessName'] = businessName;
    data['ownerName'] = ownerName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['logo'] = logo;
    data['sehrCode'] = sehrCode;
    data['lat'] = lat;
    data['lon'] = lon;
    data['about'] = about;
    data['address'] = address;
    data['tehsil'] = tehsil;
    data['district'] = district;
    data['division'] = division;
    data['province'] = province;
    data['city'] = city;
    data['country'] = country;
    data['distance'] = distance;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (grade != null) {
      data['grade'] = grade!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['verifiedAt'] = verifiedAt;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? gender;
  String? dob;
  bool? isActive;
  String? verifiedAt;
  String? avatar;
  String? phoneVerifiedAt;
  String? cnic;
  String? education;
  String? address;
  String? tehsil;
  String? district;
  String? division;
  String? province;
  String? city;
  String? country;
  String? createdAt;
  String? updatedAt;
  List<Roles>? roles;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobile,
    this.password,
    this.gender,
    this.dob,
    this.isActive,
    this.verifiedAt,
    this.avatar,
    this.phoneVerifiedAt,
    this.cnic,
    this.education,
    this.address,
    this.tehsil,
    this.district,
    this.division,
    this.province,
    this.city,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    gender = json['gender'];
    dob = json['dob'];
    isActive = json['isActive'];
    verifiedAt = json['verifiedAt'];
    avatar = json['avatar'];
    phoneVerifiedAt = json['phoneVerifiedAt'];
    cnic = json['cnic'];
    education = json['education'];
    address = json['address'];
    tehsil = json['tehsil'];
    district = json['district'];
    division = json['division'];
    province = json['province'];
    city = json['city'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['gender'] = gender;
    data['dob'] = dob;
    data['isActive'] = isActive;
    data['verifiedAt'] = verifiedAt;
    data['avatar'] = avatar;
    data['phoneVerifiedAt'] = phoneVerifiedAt;
    data['cnic'] = cnic;
    data['education'] = education;
    data['address'] = address;
    data['tehsil'] = tehsil;
    data['district'] = district;
    data['division'] = division;
    data['province'] = province;
    data['city'] = city;
    data['country'] = country;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? role;

  Roles({this.id, this.role});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    return data;
  }
}

class Grade {
  int? id;
  String? title;
  int? salesTarget;

  Grade({this.id, this.title, this.salesTarget});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    salesTarget = json['salesTarget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['salesTarget'] = salesTarget;
    return data;
  }
}

class Category {
  int? id;
  String? title;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
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
