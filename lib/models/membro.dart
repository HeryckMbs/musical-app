class Member {
  int? id;
  String? nome;
  Null? urlPhoto;
  String? dtAniversario;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? idIgreja;

  Member(
      {this.id,
      this.nome,
      this.urlPhoto,
      this.dtAniversario,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.idIgreja});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    urlPhoto = json['url_photo'];
    dtAniversario = json['dt_aniversario'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idIgreja = json['id_igreja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['url_photo'] = this.urlPhoto;
    data['dt_aniversario'] = this.dtAniversario;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_igreja'] = this.idIgreja;
    return data;
  }
}