class Token {
  String? accessToken;
  String? refreshToken;
  DateTime? validUntil;

  Token({required this.accessToken,required  this.refreshToken, required this.validUntil});

  updateData(acess,refresh,valid){
    accessToken = acess;
    refreshToken = refresh;
    validUntil = valid;
  }
  // Token.fromJson(Map<String, dynamic> json) {
  //   print(json['expires_in']);
  //   accessToken = json['access_token'];
  //   refreshToken = json['refresh_token'];
  //   validUntil = DateTime.now().add(Duration(seconds: json['expires_in']));
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['access_token'] = this.accessToken;
  //   data['refresh_token'] = this.refreshToken;
  //   data['valid_until'] = this.validUntil.toString();
  //   return data;
  // }
}