class jadwalPiket_model {
  String? id;
  String? nama;
  String? jadwalMulai;
  String? jadwalAkhir;
  String? tanggal;
  String? bulan;
  String? hari;
  int? sesi;

  jadwalPiket_model({
    this.id,
    this.nama,
    this.jadwalMulai,
    this.jadwalAkhir,
    this.tanggal,
    this.bulan,
    this.hari,
    this.sesi
  });

    Map<String, dynamic> add_data() {
    return {
      "nama":nama,
      "tanggal": tanggal,
      "bulan": bulan,
      "hari": hari,
      "jadwal mulai": jadwalMulai,
      "jadwal akhir": jadwalAkhir,
      "sesi": sesi
    };
  }



}
