class PermissionFirebase {
  late String idPermissao;
  late String nome;
  late Map<String, dynamic> igreja;
  late Map<String, dynamic> campanha;
  late Map<String, dynamic> campanha_culto;
  late Map<String, dynamic> evento;
  late Map<String, dynamic> evento_musicas;
  late Map<String, dynamic> evento_integrantes;
  late Map<String, dynamic> culto;
  late Map<String, dynamic> departamento;
  late Map<String, dynamic> departamento_integrantes;
  late Map<String, dynamic> departamento_avisos;
  late Map<String, dynamic> musicas;
  late Map<String, dynamic> pedidos_oracao;
  late Map<String, dynamic> pedidos_musica;
  late Map<String, dynamic> pastas;
  late Map<String, dynamic> cifras;
  late Map<String, dynamic> categorias;
  late Map<String, dynamic> membros;

  PermissionFirebase(
      Map<String, dynamic> igrejaReq,
      Map<String, dynamic> campanhaReq,
      Map<String, dynamic> campanha_cultoReq,
      Map<String, dynamic> eventoReq,
      Map<String, dynamic> evento_musicasReq,
      Map<String, dynamic> evento_integrantesReq,
      Map<String, dynamic> cultoReq,
      Map<String, dynamic> departamentoReq,
      Map<String, dynamic> departamento_integrantesReq,
      Map<String, dynamic> departamento_avisosReq,
      Map<String, dynamic> musicasReq,
      Map<String, dynamic> pedidos_oracaoReq,
      Map<String, dynamic> pedidos_musicaReq,
      Map<String, dynamic> pastasReq,
      Map<String, dynamic> cifrasReq,
      Map<String, dynamic> categoriasReq,
      Map<String, dynamic> membrosReq,
      String? nomeGrupo,
      String? id) {
    igreja = igrejaReq;
    campanha = campanhaReq;
    campanha_culto = campanha_cultoReq;
    evento = eventoReq;
    evento_musicas = evento_musicasReq;
    evento_integrantes = evento_integrantesReq;
    culto = cultoReq;
    departamento = departamentoReq;
    departamento_integrantes = departamento_integrantesReq;
    departamento_avisos = departamento_avisosReq;
    musicas = musicasReq;
    pedidos_oracao = pedidos_oracaoReq;
    pedidos_musica = pedidos_musicaReq;
    pastas = pastasReq;
    cifras = cifrasReq;
    categorias = categoriasReq;
    membros = membrosReq;
    nome = nomeGrupo ?? 'Padrão';
    idPermissao = id ?? '';
  }

  factory PermissionFirebase.fromJson(Map<String, dynamic> json) =>
      PermissionFirebase(
        json['igreja'],
        json['campanha'],
        json['campanha_culto'],
        json['evento'],
        json['evento_musicas'],
        json['evento_integrantes'],
        json['culto'],
        json['departamento'],
        json['departamento_integrantes'],
        json['departamento_avisos'],
        json['musicas'],
        json['pedidos_oracao'],
        json['pedidos_musica'],
        json['pastas'],
        json['cifras'],
        json['categorias'],
        json['membros'],
        json['nome'],
        json['idPermissao'],
      );

  Map<String, dynamic> toJson() {
    return {
      'igreja': igreja,
      'campanha': campanha,
      'campanha_culto': campanha_culto,
      'evento': evento,
      'evento_musicas': evento_musicas,
      'evento_integrantes': evento_integrantes,
      'culto': culto,
      'departamento': departamento,
      'departamento_integrantes': departamento_integrantes,
      'departamento_avisos': departamento_avisos,
      'musicas': musicas,
      'pedidos_oracao': pedidos_oracao,
      'pedidos_musica': pedidos_musica,
      'pastas': pastas,
      'cifras': cifras,
      'categorias': categorias,
      'membros': membros,
      'nome': nome,
      'idPermissao': idPermissao,
    };
  }
}
