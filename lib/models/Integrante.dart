class Integrante {
  int? id;
  String? nome;
  Null? apelido;
  int? userId;
  String? createdAt;
  String? updatedAt;
  bool checked = false;
  Integrante(
      {this.id,
      this.nome,
      this.apelido,
      this.userId,
      this.createdAt,
      this.updatedAt,
     });

  Integrante.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    apelido = json['apelido'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['apelido'] = this.apelido;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
