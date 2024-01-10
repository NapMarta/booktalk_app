class Libro {
  String isbn;
  String titolo;
  String autori;
  String materia;
  String edizione;
  int numPagine;

  Libro({
    required this.isbn,
    required this.titolo,
    required this.autori,
    required this.materia,
    required this.edizione,
    required this.numPagine,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return Libro(
      isbn: json['ISBN'],
      titolo: json['TITOLO'],
      autori: json['AUTORI'],
      materia: json['MATERIA'],
      edizione: json['EDIZIONE'],
      numPagine: json['NUM_PAGINE'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ISBN': isbn,
      'TITOLO': titolo,
      'AUTORI': autori,
      'MATERIA': materia,
      'EDIZIONE': edizione,
      'NUM_PAGINE': numPagine,
    };
  }

  @override
  String toString() {
    return 'Libro{ISBN: $isbn, TITOLO: $titolo, AUTORI: $autori, MATERIA: $materia, EDIZIONE: $edizione, NUM_PAGINE: $numPagine}';
  }
}