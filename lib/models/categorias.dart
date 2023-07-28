class CategoriaMusical{
  late String nome;
  late String idCategoriaMusical;
  late String descricao;
  bool checked = false;


  CategoriaMusical(String nomeCategoriaMusical, String descricaoCategoriaMusical, String id) {
    nome = nomeCategoriaMusical;
    descricao = descricaoCategoriaMusical;
    idCategoriaMusical = id;
  }

}