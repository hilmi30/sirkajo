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
  String kodeBlok;
  String lantai;
  String kodeKamar;
  String hargaSewa;
  String satuan;

  Data(
      {this.idSewa,
        this.kodeBlok,
        this.lantai,
        this.kodeKamar,
        this.hargaSewa,
        this.satuan});

  Data.fromJson(Map<String, dynamic> json) {
    idSewa = json['id_sewa'];
    kodeBlok = json['kode_blok'];
    lantai = json['lantai'];
    kodeKamar = json['kode_kamar'];
    hargaSewa = json['harga_sewa'];
    satuan = json['satuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sewa'] = this.idSewa;
    data['kode_blok'] = this.kodeBlok;
    data['lantai'] = this.lantai;
    data['kode_kamar'] = this.kodeKamar;
    data['harga_sewa'] = this.hargaSewa;
    data['satuan'] = this.satuan;
    return data;
  }
}