class Departamento {
  int? id;
  String? nome;
  String? descricao;
  String? objetivo;
  String? backgroundUrl;
  int? louvor;
  int? idLider;
  int? idIgreja;
  String? createdAt;
  String? updatedAt;

  Departamento(
      {this.id,
      this.nome,
      this.descricao,
      this.objetivo,
      this.backgroundUrl,
      this.louvor,
      this.idLider,
      this.idIgreja,
      this.createdAt,
      this.updatedAt});

  Departamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    objetivo = json['objetivo'];
    backgroundUrl = json['backgroundUrl'];
    louvor = json['louvor'];
    idLider = json['id_lider'];
    idIgreja = json['id_igreja'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['objetivo'] = this.objetivo;
    data['backgroundUrl'] = this.backgroundUrl;
    data['louvor'] = this.louvor;
    data['id_lider'] = this.idLider;
    data['id_igreja'] = this.idIgreja;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}