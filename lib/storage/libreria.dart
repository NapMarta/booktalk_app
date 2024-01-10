class Libreria {
  int utente;
  int numLibri;
  String? materia1;
  String? materia2;
  String? materia3;

  Libreria({
    required this.utente,
    required this.numLibri,
    this.materia1,
    this.materia2,
    this.materia3,
  });

  factory Libreria.fromJson(Map<String, dynamic> json) {
    return Libreria(
      utente: json['UTENTE'],
      numLibri: json['NUMLIBRI'],
      materia1: json['MATERIA1'],
      materia2: json['MATERIA2'],
      materia3: json['MATERIA3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UTENTE': utente,
      'NUMLIBRI': numLibri,
      'MATERIA1': materia1,
      'MATERIA2': materia2,
      'MATERIA3': materia3,
    };
  }

  @override
  String toString() {
    return 'Libreria{UTENTE: $utente, NUMLIBRI: $numLibri, MATERIA1: $materia1, MATERIA2: $materia2, MATERIA3: $materia3}';
  }
}