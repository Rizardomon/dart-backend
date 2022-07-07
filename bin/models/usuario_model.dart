class UsuarioModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UsuarioModel();

  UsuarioModel.create(
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  );

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  factory UsuarioModel.fromEmail(Map map) {
    return UsuarioModel()
      ..id = map['id']?.toInt()
      ..password = map['password'];
  }

  factory UsuarioModel.fromRequest(Map map) {
    return UsuarioModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, name: $name, email: $email, isActive: $isActive, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.isActive == isActive &&
        other.dtCreated == dtCreated &&
        other.dtUpdated == dtUpdated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        isActive.hashCode ^
        dtCreated.hashCode ^
        dtUpdated.hashCode;
  }
}
