class Capitolo {
  int numero;
  String libro;
  String titolo;

  Capitolo({
    required this.numero,
    required this.libro,
    required this.titolo,
  });

  factory Capitolo.fromJson(Map<String, dynamic> json) {
    return Capitolo(
      numero: json['NUMERO'],
      libro: json['LIBRO'],
      titolo: json['TITOLO'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NUMERO': numero,
      'LIBRO': libro,
      'TITOLO': titolo,
    };
  }

  @override
  String toString() {
    return 'Capitolo{numero: $numero, libro: $libro, titolo: $titolo}';
  }
}
