class Ministerio{
  late String nome;
    late String idMinisterio;
  late String? backgroundPhoto;
  List<dynamic>usuarios = [];
 
  Ministerio(String nomeMinisterio,List<dynamic> usuariosDoMinisterio,String idMinisterioI, String? backgroundPhotoReq) {
    nome = nomeMinisterio;
    usuarios = usuariosDoMinisterio;
    backgroundPhoto = backgroundPhotoReq;
    idMinisterio = idMinisterioI;

  }

}