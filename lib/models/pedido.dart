
class Pedido {
  late String idPedido;
  late String musica;
  late String mensagemPedido;
  late String idMinisterio;
  late String solicitante;


  Pedido(String id,String music,String ministerio, String mensagem,String solicitant,){
    idPedido = id;
    musica = music;
    idMinisterio = ministerio;
    mensagemPedido = mensagem;
    solicitante = solicitant;
  }
}
