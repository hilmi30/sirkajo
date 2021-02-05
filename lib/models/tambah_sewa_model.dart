class TambahSewaModel {
  int status;
  bool success;
  Message message;

  TambahSewaModel({this.status, this.success, this.message});

  TambahSewaModel.fromJson(Map<String, dynamic> json) {
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
  String idSewa;
  String tanggalSewa;
  String idPenyewa;
  String idKamar;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  Null deletedAt;

  Message(
      {this.idSewa,
        this.tanggalSewa,
        this.idPenyewa,
        this.idKamar,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Message.fromJson(Map<String, dynamic> json) {
    idSewa = json['id_sewa'];
    tanggalSewa = json['tanggal_sewa'];
    idPenyewa = json['id_penyewa'];
    idKamar = json['id_kamar'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sewa'] = this.idSewa;
    data['tanggal_sewa'] = this.tanggalSewa;
    data['id_penyewa'] = this.idPenyewa;
    data['id_kamar'] = this.idKamar;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
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