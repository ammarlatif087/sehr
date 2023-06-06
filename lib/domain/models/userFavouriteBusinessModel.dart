class UserFavouriteBusiness {
  int? businessId;
  int? userId;
  Business? business;

  UserFavouriteBusiness({this.businessId, this.userId, this.business});

  UserFavouriteBusiness.fromJson(Map<String, dynamic> json) {
    businessId = json['businessId'];
    userId = json['userId'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessId'] = this.businessId;
    data['userId'] = this.userId;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  String? businessName;
  String? ownerName;
  String? email;
  String? mobile;
  String? verifiedAt;
  Null logo;
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
  String? createdAt;
  String? updatedAt;

  Business(
      {this.id,
      this.businessName,
      this.ownerName,
      this.email,
      this.mobile,
      this.verifiedAt,
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
      this.createdAt,
      this.updatedAt});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    ownerName = json['ownerName'];
    email = json['email'];
    mobile = json['mobile'];
    verifiedAt = json['verifiedAt'];
    // logo = json['logo'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['ownerName'] = this.ownerName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['verifiedAt'] = this.verifiedAt;
    data['logo'] = this.logo;
    data['sehrCode'] = this.sehrCode;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['about'] = this.about;
    data['address'] = this.address;
    data['tehsil'] = this.tehsil;
    data['district'] = this.district;
    data['division'] = this.division;
    data['province'] = this.province;
    data['city'] = this.city;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
