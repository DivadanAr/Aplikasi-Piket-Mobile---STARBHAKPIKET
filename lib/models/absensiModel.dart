class absensi_model {
  String? id;
  List<String?>? izin;
  List<String?>? sakit;
  List<String?>? alfa;
  String? kelas;
  String? foto;
  String? tanggal;
  String? bulan;
  String? hari;
  int? sesi;

  absensi_model({
    this.id,
    this.izin,
    this.sakit,
    this.alfa,
    this.kelas,
    this.foto,
    this.tanggal,
    this.bulan,
    this.hari,
    this.sesi
  });

    Map<String, dynamic> add_data() {
    return {
      "izin":izin,
      "sakit":sakit,
      "alfa":alfa,
      "kelas":kelas,
      "tanggal": tanggal,
      "bulan": bulan,
      "hari": hari,
      "foto": foto,
      "sesi": sesi
    };
  }



}
