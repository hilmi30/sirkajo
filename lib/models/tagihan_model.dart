class TagihanModel {
  int status;
  bool success;
  Data data;
  String message;

  TagihanModel({this.status, this.success, this.data, this.message});

  TagihanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String idSewa;
  String tanggalSewa;
  String idPenyewa;
  String idKamar;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  Null deletedAt;
  String kodeKamar;
  String idPemilik;
  String idKategori;
  String idLantai;
  String hargaSewa;
  String satuan;
  String keteranganKamar;
  String namaKategori;
  String keteranganKategoriKamar;
  String lantai;
  String keteranganLantai;
  String id;
  String email;
  String username;
  String fullname;
  String phone;
  String avatar;
  String noKk;
  String noKtp;
  String nik;
  String passwordHash;
  String resetHash;
  String resetAt;
  String resetExpires;
  String activateHash;
  String status;
  String statusMessage;
  String active;
  String forcePassReset;
  String address;
  String tokenFcm;

  Data(
      {this.idSewa,
        this.tanggalSewa,
        this.idPenyewa,
        this.idKamar,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.kodeKamar,
        this.idPemilik,
        this.idKategori,
        this.idLantai,
        this.hargaSewa,
        this.satuan,
        this.keteranganKamar,
        this.namaKategori,
        this.keteranganKategoriKamar,
        this.lantai,
        this.keteranganLantai,
        this.id,
        this.email,
        this.username,
        this.fullname,
        this.phone,
        this.avatar,
        this.noKk,
        this.noKtp,
        this.nik,
        this.passwordHash,
        this.resetHash,
        this.resetAt,
        this.resetExpires,
        this.activateHash,
        this.status,
        this.statusMessage,
        this.active,
        this.forcePassReset,
        this.address,
        this.tokenFcm});

  Data.fromJson(Map<String, dynamic> json) {
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
    kodeKamar = json['kode_kamar'];
    idPemilik = json['id_pemilik'];
    idKategori = json['id_kategori'];
    idLantai = json['id_lantai'];
    hargaSewa = json['harga_sewa'];
    satuan = json['satuan'];
    keteranganKamar = json['keterangan_kamar'];
    namaKategori = json['nama_kategori'];
    keteranganKategoriKamar = json['keterangan_kategori_kamar'];
    lantai = json['lantai'];
    keteranganLantai = json['keterangan_lantai'];
    id = json['id'];
    email = json['email'];
    username = json['username'];
    fullname = json['fullname'];
    phone = json['phone'];
    avatar = json['avatar'];
    noKk = json['no_kk'];
    noKtp = json['no_ktp'];
    nik = json['nik'];
    passwordHash = json['password_hash'];
    resetHash = json['reset_hash'];
    resetAt = json['reset_at'];
    resetExpires = json['reset_expires'];
    activateHash = json['activate_hash'];
    status = json['status'];
    statusMessage = json['status_message'];
    active = json['active'];
    forcePassReset = json['force_pass_reset'];
    address = json['address'];
    tokenFcm = json['token_fcm'];
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
    data['kode_kamar'] = this.kodeKamar;
    data['id_pemilik'] = this.idPemilik;
    data['id_kategori'] = this.idKategori;
    data['id_lantai'] = this.idLantai;
    data['harga_sewa'] = this.hargaSewa;
    data['satuan'] = this.satuan;
    data['keterangan_kamar'] = this.keteranganKamar;
    data['nama_kategori'] = this.namaKategori;
    data['keterangan_kategori_kamar'] = this.keteranganKategoriKamar;
    data['lantai'] = this.lantai;
    data['keterangan_lantai'] = this.keteranganLantai;
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['no_kk'] = this.noKk;
    data['no_ktp'] = this.noKtp;
    data['nik'] = this.nik;
    data['password_hash'] = this.passwordHash;
    data['reset_hash'] = this.resetHash;
    data['reset_at'] = this.resetAt;
    data['reset_expires'] = this.resetExpires;
    data['activate_hash'] = this.activateHash;
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    data['active'] = this.active;
    data['force_pass_reset'] = this.forcePassReset;
    data['address'] = this.address;
    data['token_fcm'] = this.tokenFcm;
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
