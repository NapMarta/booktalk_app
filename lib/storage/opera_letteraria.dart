class OperaLetteraria {
  String titolo;
  int capitolo;
  String libro;
  String autori;

  OperaLetteraria({
    required this.titolo,
    required this.capitolo,
    required this.libro,
    required this.autori,
  });

  factory OperaLetteraria.fromJson(Map<String, dynamic> json) {
    return OperaLetteraria(
      titolo: json['TITOLO'],
      capitolo: json['CAPITOLO'],
      libro: json['LIBRO'],
      autori: json['AUTORI'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TITOLO': titolo,
      'CAPITOLO': capitolo,
      'LIBRO': libro,
      'AUTORI': autori,
    };
  }

  @override
  String toString() {
    return 'OperaLetteraria { TITOLO: $titolo, CAPITOLO: $capitolo, LIBRO: $libro, AUTORI: $autori }';
  }
}