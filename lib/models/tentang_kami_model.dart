class TentangKamiModel {
  String idTentang;
  String judul;
  String isi;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  Null deletedAt;

  TentangKamiModel(
      {this.idTentang,
        this.judul,
        this.isi,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  TentangKamiModel.fromJson(Map<String, dynamic> json) {
    idTentang = json['id_tentang'];
    judul = json['judul'];
    isi = json['isi'];
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
    data['id_tentang'] = this.idTentang;
    data['judul'] = this.judul;
    data['isi'] = this.isi;
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