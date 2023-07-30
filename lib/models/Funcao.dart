class Funcao {
  int? id;
  int? idDepartamento;
  String? nome;
  String? descricao;
  String? createdAt;
  String? updatedAt;

  Funcao(
      {this.id,
      this.idDepartamento,
      this.nome,
      this.descricao,
      this.createdAt,
      this.updatedAt});

  Funcao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idDepartamento = json['id_departamento'];
    nome = json['nome'];
    descricao = json['descricao'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_departamento'] = this.idDepartamento;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}