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
      map['dt_autalizacao'],
    );
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, name: $name, email: $email, isActive: $isActive, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
}