class jadwalTamu_model {
  String? id;
  String? nama;
  String? namaInstansi;
  String? tujuan;
  String? tanggal;
  String? jam;
  String? keterangan;

  jadwalTamu_model({
    this.id,
    this.nama,
    this.namaInstansi,
    this.tujuan,
    this.tanggal,
    this.jam,
    this.keterangan
  });

    Map<String, dynamic> add_data() {
    return {
      "nama":nama,
      "instansi": namaInstansi,
      "tanggal": tanggal,
      "tujuan": tujuan,
      "jam": jam,
      "keterangan": keterangan
    };
  }



}
