import 'dart:convert';

UserSingUpDto userSingUpDtoFromJson(String str) =>
UserSingUpDto.fromJson(json.decode(str));

class UserSingUpDto {
 
  final String nombre;
  final String correo;
  final String password;
  final String telefono;
  final String Direccion;

  UserSingUpDto({

    required this.nombre,
    required this.correo,
    required this.password,
    required this.telefono,
    required this.Direccion

  });

  factory UserSingUpDto.fromJson(Map<String, dynamic> json) {
    return UserSingUpDto(
      nombre: json['nombre'],
      correo: json['correo'],
      password: json['password'],
      telefono: json ['telefono'],
      Direccion: json['Direccion']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'password': password,
      'telefono': telefono,
      'Direccion': Direccion};}
}