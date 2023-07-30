import 'package:flutter/foundation.dart';

import 'Permission.dart';

class UserCustom {
  late PermissionFirebase permissoes;
  late int idUser;
  late String? access_token;
  late int? igreja_selecionada;
  late var user;
  UserCustom(
      int idUserReq, PermissionFirebase permission, UserAuthenticadedReq,String? access_tokenReq,
int? igreja_selecionadaReq) {
    permissoes = permission;
    idUser = idUserReq;
    user = UserAuthenticadedReq;
    igreja_selecionada = igreja_selecionadaReq;
    access_token = access_tokenReq;
  }

  void setPermissions(PermissionFirebase permissions) {
    permissoes = permissions;
  }

  void setAcessToken(String access_tokenReq) {
    access_token = access_tokenReq;
  }

  void setIgrejaSelecionada(int igreja_selecionadaReq) {
    igreja_selecionada = igreja_selecionadaReq;
  }

  factory UserCustom.fromJson(Map<String, dynamic> json) {
    
    UserCustom usuario =
        UserCustom(json['id'], PermissionFirebase.fromJson(json['permissoes']), json['user'],json['access_token'],json['igreja_selecionada']);
    return usuario;
  }

  Map<String, dynamic> toJson(){
      return  {
        'id': idUser,
        'permissoes': permissoes.toJson(),
        'user': user,
        'access_token': access_token,
        'igreja_selecionada': igreja_selecionada
      };
  }
}
