class Igreja {
  int? id;
  String? nome;
  String? telefone;
  int? idPastor;
  String? createdAt;
  String? updatedAt;

  Igreja(
      {this.id,
      this.nome,
      this.telefone,
      this.idPastor,
      this.createdAt,
      this.updatedAt});

  Igreja.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    idPastor = json['id_pastor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['id_pastor'] = this.idPastor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}