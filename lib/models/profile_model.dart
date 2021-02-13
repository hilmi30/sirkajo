class ProfileModel {
  int status;
  bool success;
  Message message;

  ProfileModel({this.status, this.success, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Message {
  String id;
  String email;
  String username;
  String passwordHash;
  String resetHash;
  ResetExpires resetExpires;
  bool active;
  bool forcePassReset;
  ResetExpires createdAt;
  ResetExpires updatedAt;
  String fullname;
  String phone;
  String avatar;
  String address;
  String tokenFcm;

  Message(
      {this.id,
        this.email,
        this.username,
        this.passwordHash,
        this.resetHash,
        this.resetExpires,
        this.active,
        this.forcePassReset,
        this.createdAt,
        this.updatedAt,
        this.fullname,
        this.phone,
        this.avatar,
        this.address,
        this.tokenFcm});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    passwordHash = json['password_hash'];
    resetHash = json['reset_hash'];
    resetExpires = json['reset_expires'] != null
        ? new ResetExpires.fromJson(json['reset_expires'])
        : null;
    active = json['active'];
    forcePassReset = json['force_pass_reset'];
    createdAt = json['created_at'] != null
        ? new ResetExpires.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new ResetExpires.fromJson(json['updated_at'])
        : null;
    fullname = json['fullname'];
    phone = json['phone'];
    avatar = json['avatar'];
    address = json['address'];
    tokenFcm = json['token_fcm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password_hash'] = this.passwordHash;
    data['reset_hash'] = this.resetHash;
    if (this.resetExpires != null) {
      data['reset_expires'] = this.resetExpires.toJson();
    }
    data['active'] = this.active;
    data['force_pass_reset'] = this.forcePassReset;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    data['token_fcm'] = this.tokenFcm;
    return data;
  }
}

class ResetExpires {
  String date;
  int timezoneType;
  String timezone;

  ResetExpires({this.date, this.timezoneType, this.timezone});

  ResetExpires.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}