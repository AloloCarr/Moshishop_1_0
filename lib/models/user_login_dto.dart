import 'dart:convert';

UserLoginDto userLoginDtoFromJson(String str) =>
UserLoginDto.fromJson(json.decode(str));

class UserLoginDto {
 
  final String correo;
  final String password;



  UserLoginDto({

    required this.correo,
    required this.password,
  

  });

  factory UserLoginDto.fromJson(Map<String, dynamic> json) {
    return UserLoginDto(
      correo: json['correo'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'password': password,};}
}