import 'Permission.dart';

class UserCustom {
  late PermissionFirebase permissoes;
  late String idUser;
  late String access_token;
  late var user;
  UserCustom(String idUserReq, 
      PermissionFirebase permission,UserAuthenticadedReq) {
    permissoes = permission;
    idUser = idUserReq;
    user = UserAuthenticadedReq;
  }



  void updatePermissions( PermissionFirebase permissions){
    permissoes = permissions;
  }

  
}
