class MessageModel {
  String id;
  String email;
  String username;
  String fullname;
  String phone;
  String nokk;
  String noktp;

  MessageModel({this.id, this.email, this.username, this.fullname, this.phone,
  this.nokk, this.noktp});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      fullname: json['fullname'],
      phone: json['phone'],
      nokk: json['no_kk'],
      noktp: json['no_ktp'],
    );
  }
}