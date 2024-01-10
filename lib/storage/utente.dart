class Utente {
  int? id;
  String nome;
  String cognome;
  String email;
  String password;
  List<int>? foto; // Potrebbe essere nullabile 
  int? ultfunz1; // Potrebbe essere nullabile 
  int? ultfunz2;
  int? ultfunz3;

  Utente({
    this.id,
    required this.nome,
    required this.cognome,
    required this.email,
    required this.password,
    this.foto,
    this.ultfunz1,
    this.ultfunz2,
    this.ultfunz3,
  });

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      id: json['ID'],
      nome: json['NOME'],
      cognome: json['COGNOME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
      foto: json['FOTO'], // Nota: potrebbe essere necessaria la conversione, a seconda del formato
      ultfunz1: json['ULTFUNZ1'],
      ultfunz2: json['ULTFUNZ2'],
      ultfunz3: json['ULTFUNZ3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'NOME': nome,
      'COGNOME': cognome,
      'EMAIL': email,
      'PASSWORD': password,
      'FOTO': foto,
      'ULTFUNZ1': ultfunz1,
      'ULTFUNZ2': ultfunz2,
      'ULTFUNZ3': ultfunz3,
    };
  }

  @override
  String toString() {
    return 'Utente{id: $id, nome: $nome, cognome: $cognome, email: $email, password: $password, '
        'foto: $foto, ultfunz1: $ultfunz1, ultfunz2: $ultfunz2, ultfunz3: $ultfunz3}';
  }
}
