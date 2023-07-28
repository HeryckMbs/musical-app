class Musica {
  late String nome;
  late String idMusica;
  late String nomeAutor;
  late List<dynamic> tonalidade;
  late List<dynamic> caminhoPdf;
  late String videoYt;
  late String letraMusica;
  late List<dynamic> categorias;

  bool selecionado = false;

  Musica(
    String nomeRequest,
    String idMusicaRequest,
    String nomeAutorRequest,
    List<dynamic> tonalidadeRequest,
    List<dynamic> caminhoPdfRequest,
    String videoYtRequest,
    String letraMusicaRequest,
      List<dynamic>  idCategoriaRequest,
  ) {
    nome = nomeRequest;
    idMusica = idMusicaRequest;
    nomeAutor = nomeAutorRequest;
    tonalidade = tonalidadeRequest;
    caminhoPdf = caminhoPdfRequest;
    videoYt = videoYtRequest;
    letraMusica = letraMusicaRequest;
    categorias = idCategoriaRequest;
  }
}
