class UserInfo {
  final String login;
  final int id;
  final String avatarUl;
  final String email;

  UserInfo({this.login, this.id, this.avatarUl, this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) => new UserInfo(
      login: json['login'],
      id: json['id'],
      avatarUl: json['avatar_url'],
      email: json['email']);

  Map<String, dynamic> toJson() => {
        'login': this.login,
        'id': this.id,
        'avatar_url': this.avatarUl,
        'email': this.email
      };
}
