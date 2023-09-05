class Sessao{
  late int idEquipe_selecionada;

  Sessao({required this.idEquipe_selecionada});

  void setEquipe(equipe){
    idEquipe_selecionada = equipe;
  }
}