class TagihanAttModel {
  String tanggalSewa;
  String kodeKamar;
  String lantai;
  String hargaSewa;
  String satuan;
  String keteranganKamar;
  String penyewa;
  String pemilik;

  TagihanAttModel({this.tanggalSewa, this.kodeKamar, this.lantai, this.hargaSewa,
    this.satuan, this.keteranganKamar, this.penyewa, this.pemilik});

  factory TagihanAttModel.fromJson(Map<String, dynamic> json) {
    return TagihanAttModel(
      tanggalSewa: json['tanggal_sewa'],
      kodeKamar: json['kode_kamar'],
      lantai: json['lantai'],
      hargaSewa: json['harga_sewa'],
      satuan: json['satuan'],
      keteranganKamar: json['keterangan_kamar'],
      penyewa: json['penyewa'],
      pemilik: json['pemilik']
    );
  }
}