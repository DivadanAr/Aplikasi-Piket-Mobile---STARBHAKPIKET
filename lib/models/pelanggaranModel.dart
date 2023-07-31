class pelanggaran_model {
  String? id;
  String? nama;
  String? kelas;
  String? pelanggaran;
  String? jam;
  String? tanggal;

  pelanggaran_model({
    this.id,
    this.nama,
    this.kelas,
    this.pelanggaran,
    this.jam,
    this.tanggal,
  });

    Map<String, dynamic> add_data() {
    return {
      "nama": nama,
      "kelas": kelas,
      "pelanggaran": pelanggaran,
      "jam": jam,
      "tanggal": tanggal,
    };
  }



}
