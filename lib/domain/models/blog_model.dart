class BlogModel {
  int? total;
  List<Posts>? posts;

  BlogModel({this.total, this.posts});

  BlogModel.fromJson(Map<String, dynamic> json) {
    // print(json);
    total = json['total'];
    print(total);
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
    print(posts![0].content);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  String? title;
  String? content;
  String? description;
  String? image;
  String? video;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<Likes>? likes;
  List<Comments>? comments;

  Posts(
      {this.id,
      this.title,
      this.content,
      this.description,
      this.image,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.likes,
      this.comments});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['description'] = description;
    data['image'] = image;
    data['video'] = video;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
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

  User(
      {this.id,
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
      this.roles});

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

class Likes {
  // int? id;
  // int? like;

  Likes(
      //   {
      //   this.id,
      //   this.like,
      // }
      );

  Likes.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['like'] = like;
    return data;
  }
}

class Comments {
  // int? id;
  // String? comment;

  // Comments({
  //   this.id,
  //   this.comment,
  // }
  // );

  Comments.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['comment'] = comment;
    return data;
  }
}
