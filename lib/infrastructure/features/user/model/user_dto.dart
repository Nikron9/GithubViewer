class UserDTO {
  final String login;

  UserDTO({required this.login});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      login: json['login'],
    );
  }
}
