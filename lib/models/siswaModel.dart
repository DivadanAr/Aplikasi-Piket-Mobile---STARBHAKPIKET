class siswa_model {
  String? id;
  String? nama;
  String? nisn;
  String? nipd;
  String? kelas;
  String? jurusan;
  String? kelamin;
  String? agama;



  siswa_model({
    this.id,
    this.nama,
    this.nisn,
    this.nipd,
    this.kelas,
    this.jurusan,
    this.kelamin,
    this.agama,
  });

    Map<String, dynamic> add_data() {
    return {
      "nama":nama,
      "nisn": nisn,
      "nipd": nipd,
      "kelas": kelas,
      "jurusan":jurusan,
      "kelamin": kelamin,
      "agama": agama,
    };
  }



}
