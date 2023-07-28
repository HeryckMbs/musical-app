class Funcao{
  late String nome;
  late String idFuncao;
    late String descricao;
    bool selecionado = false;

 
  Funcao(String nomeFuncao, String descricaoFuncao, String id) {
    nome = nomeFuncao;
    descricao = descricaoFuncao; 
    idFuncao = id;
  }

}