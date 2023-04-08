class Kamus {
  String? id;
  String? kataSahu;
  String? kataIndonesia;

  Kamus({
    required this.id,
    required this.kataSahu,
    required this.kataIndonesia,
  });

  Kamus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kataSahu = json['kataSahu'];
    kataIndonesia = json['kataIndonesia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kataSahu'] = kataSahu;
    data['kataIndonesia'] = kataIndonesia;
    return data;
  }
}
