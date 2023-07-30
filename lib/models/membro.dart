class Member {
  int? id;
  String? nome;
  String? urlPhoto;
  String? dtAniversario;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? idIgreja;
  Pivot? pivot;
  List<Functions>? functions;
  bool checked = false;

  Member(
      {this.id,
      this.nome,
      this.urlPhoto,
      this.dtAniversario,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.idIgreja,
      this.pivot,
      this.functions});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    urlPhoto = json['url_photo'];
    dtAniversario = json['dt_aniversario'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idIgreja = json['id_igreja'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['functions'] != null) {
      functions = <Functions>[];
      json['functions'].forEach((v) {
        functions!.add(new Functions.fromJson(v));
      });
    }
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.functions != null) {
      data['functions'] = this.functions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? idDepartamento;
  int? id_membro;

  Pivot({this.idDepartamento, this.id_membro});

  Pivot.fromJson(Map<String, dynamic> json) {
    idDepartamento = json['id_departamento'];
    id_membro = json['id_membro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_departamento'] = this.idDepartamento;
    data['id_membro'] = this.id_membro;
    return data;
  }
}

class Functions {
  int? id;
  int? idDepartamento;
  String? nome;
  String? descricao;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Functions(
      {this.id,
      this.idDepartamento,
      this.nome,
      this.descricao,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Functions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idDepartamento = json['id_departamento'];
    nome = json['nome'];
    descricao = json['descricao'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_departamento'] = this.idDepartamento;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}