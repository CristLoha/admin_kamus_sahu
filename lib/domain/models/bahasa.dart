class LanguageModel {
  String? id;
  String? name;
  String? code;
  String? kata;
  String? contohKata;
  String? audioUrlPria;
  String? audioUrlWanita;
  String? kategori;

  LanguageModel({
    this.id,
    this.name,
    this.code,
    this.kata,
    this.contohKata,
    this.audioUrlPria,
    this.audioUrlWanita,
    this.kategori,
  });

  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    kata = json['kataSahu'];
    contohKata = json['contohKataSahu'];
    audioUrlPria = json['audioUrlPria'];
    audioUrlWanita = json['audioUrlWanita'];
    kategori = json['kategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['kataSahu'] = kata;
    data['contohKataSahu'] = contohKata;
    data['audioUrlPria'] = audioUrlPria;
    data['audioUrlWanita'] = audioUrlWanita;
    data['kategori'] = kategori;
    return data;
  }
}
