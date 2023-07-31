class kelas_model {
  String? id;
  String? nama;
  String? jurusan;
  String? guru;
  int? sesi;
  int? jumlah;



  kelas_model({
    this.id,
    this.nama,
    this.jurusan,
    this.guru,
    this.sesi,
    this.jumlah,
  });

    Map<String, dynamic> add_data() {
    return {
      "nama":nama,
      "jurusan":jurusan,
      "guru": guru,
      "sesi": sesi,
      "jumlah": jumlah,
    };
  }



}
