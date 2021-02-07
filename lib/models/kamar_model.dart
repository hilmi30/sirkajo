class KamarModel {
  List<Data> data;

  KamarModel({this.data});

  KamarModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String type;
  String id;
  Attributes attributes;

  Data({this.type, this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}

class Attributes {
  String kodeKamar;
  String hargaSewa;
  String satuan;
  String keteranganKamar;
  String pemilik;
  String kategoriKamar;
  String lantai;
  String kodeBlok;
  CreatedAt createdAt;
  CreatedAt updatedAt;

  Attributes(
      {this.kodeKamar,
        this.hargaSewa,
        this.satuan,
        this.keteranganKamar,
        this.pemilik,
        this.kategoriKamar,
        this.lantai,
        this.kodeBlok,
        this.createdAt,
        this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    kodeKamar = json['kode_kamar'];
    hargaSewa = json['harga_sewa'];
    satuan = json['satuan'];
    keteranganKamar = json['keterangan_kamar'];
    pemilik = json['pemilik'];
    kategoriKamar = json['kategori_kamar'];
    lantai = json['lantai'];
    kodeBlok = json['kode_blok'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_kamar'] = this.kodeKamar;
    data['harga_sewa'] = this.hargaSewa;
    data['satuan'] = this.satuan;
    data['keterangan_kamar'] = this.keteranganKamar;
    data['pemilik'] = this.pemilik;
    data['kategori_kamar'] = this.kategoriKamar;
    data['lantai'] = this.lantai;
    data['kode_blok'] = this.kodeBlok;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
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
