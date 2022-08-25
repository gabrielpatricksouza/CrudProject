class UserModel {
  String name;
  String email;
  String cpf;
  String phone;
  String password;
  String maritalStatus;
  String genre;

  UserModel({
    this.name = '',
    this.email = '',
    this.cpf = '',
    this.phone = '',
    this.password = '',
    this.maritalStatus = '',
    this.genre = '',
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "cpf": cpf,
      "genre": genre,
      "phone": phone,
      "maritalStatus": maritalStatus,
    };
    return map;
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> dados) {
    return UserModel(
      name: dados['name'] ?? '',
      email: dados['email'] ?? '',
      cpf: dados['cpf'] ?? '',
      genre: dados['sexo'] ?? '',
      phone: dados['telefone'] ?? '',
      maritalStatus: dados['estado_civil'] ?? '',
      password: dados['password'] ?? '',
    );

    //TODO: Revisar
    ///Como estáva antes {nomes dentro de [] estáva errado}
    // return UserModel(
    //   name: dados['name'] ?? '',
    //   email: dados['email'] ?? '',
    //   cpf: dados['cpf'] ?? '',
    //   genre: dados['genre'] ?? '',
    //   phone: dados['phone'] ?? '',
    //   maritalStatus: dados['maritalStatus'] ?? '',
    //   password: dados['password'] ?? '',
    // );
  }

  factory UserModel.clean() {
    return UserModel(name: '', email: '',);
  }
}
