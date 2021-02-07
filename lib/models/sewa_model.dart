class SewaModel {
  int status;
  Data data;

  SewaModel({this.status, this.data});

  SewaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
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
  String tanggalSewa;
  String kodeKamar;
  String lantai;
  String hargaSewa;
  String satuan;
  String keteranganKamar;
  String penyewa;
  String pemilik;
  String kategoriKamar;
  CreatedAt createdAt;
  List<Pembayaran> pembayaran;
  List<Keluhan> keluhan;

  Attributes(
      {this.tanggalSewa,
        this.kodeKamar,
        this.lantai,
        this.hargaSewa,
        this.satuan,
        this.keteranganKamar,
        this.penyewa,
        this.pemilik,
        this.kategoriKamar,
        this.createdAt,
        this.pembayaran,
        this.keluhan});

  Attributes.fromJson(Map<String, dynamic> json) {
    tanggalSewa = json['tanggal_sewa'];
    kodeKamar = json['kode_kamar'];
    lantai = json['lantai'];
    hargaSewa = json['harga_sewa'];
    satuan = json['satuan'];
    keteranganKamar = json['keterangan_kamar'];
    penyewa = json['penyewa'];
    pemilik = json['pemilik'];
    kategoriKamar = json['kategori_kamar'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    if (json['pembayaran'] != null) {
      pembayaran = new List<Pembayaran>();
      json['pembayaran'].forEach((v) {
        pembayaran.add(new Pembayaran.fromJson(v));
      });
    }
    if (json['keluhan'] != null) {
      keluhan = new List<Keluhan>();
      json['keluhan'].forEach((v) {
        keluhan.add(new Keluhan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal_sewa'] = this.tanggalSewa;
    data['kode_kamar'] = this.kodeKamar;
    data['lantai'] = this.lantai;
    data['harga_sewa'] = this.hargaSewa;
    data['satuan'] = this.satuan;
    data['keterangan_kamar'] = this.keteranganKamar;
    data['penyewa'] = this.penyewa;
    data['pemilik'] = this.pemilik;
    data['kategori_kamar'] = this.kategoriKamar;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.pembayaran != null) {
      data['pembayaran'] = this.pembayaran.map((v) => v.toJson()).toList();
    }
    if (this.keluhan != null) {
      data['keluhan'] = this.keluhan.map((v) => v.toJson()).toList();
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

class Pembayaran {
  String idHistoriPembayaran;
  String idSewa;
  String tanggalBayar;
  String jumlahBayar;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Pembayaran(
      {this.idHistoriPembayaran,
        this.idSewa,
        this.tanggalBayar,
        this.jumlahBayar,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Pembayaran.fromJson(Map<String, dynamic> json) {
    idHistoriPembayaran = json['id_histori_pembayaran'];
    idSewa = json['id_sewa'];
    tanggalBayar = json['tanggal_bayar'];
    jumlahBayar = json['jumlah_bayar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_histori_pembayaran'] = this.idHistoriPembayaran;
    data['id_sewa'] = this.idSewa;
    data['tanggal_bayar'] = this.tanggalBayar;
    data['jumlah_bayar'] = this.jumlahBayar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Keluhan {
  String idKeluhan;
  String idSewa;
  String foto;
  String isiKeluhan;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Keluhan(
      {this.idKeluhan,
        this.idSewa,
        this.foto,
        this.isiKeluhan,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Keluhan.fromJson(Map<String, dynamic> json) {
    idKeluhan = json['id_keluhan'];
    idSewa = json['id_sewa'];
    foto = json['foto'];
    isiKeluhan = json['isi_keluhan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_keluhan'] = this.idKeluhan;
    data['id_sewa'] = this.idSewa;
    data['foto'] = this.foto;
    data['isi_keluhan'] = this.isiKeluhan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
