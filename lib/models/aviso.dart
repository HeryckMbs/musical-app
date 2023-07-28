
class Aviso {
  late String idAviso;
  late String aviso;
  late String tituloAviso;
  late String idMinisterio;
  late String avisante;

  Aviso(String idAvisoReq, String asvisoReq, String tituloAvisoReq,
      String idMinisterioReq,String avisanteReq) {
    idAviso = idAvisoReq;
    aviso = asvisoReq;
    tituloAviso = tituloAvisoReq;
    idMinisterio = idMinisterioReq;
    avisante = avisanteReq;
  }
}
