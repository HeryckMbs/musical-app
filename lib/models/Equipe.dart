class Equipe {
  int? id;
  String? nome;
  String? codigo;
  int? open;
  String? descricao;
  Null? qrCode;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  Equipe(
      {this.id,
        this.nome,
        this.codigo,
        this.open,
        this.descricao,
        this.qrCode,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.laravelThroughKey});

  Equipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    codigo = json['codigo'];
    open = json['open'];
    descricao = json['descricao'];
    qrCode = json['qr_code'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    data['open'] = this.open;
    data['descricao'] = this.descricao;
    data['qr_code'] = this.qrCode;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}
