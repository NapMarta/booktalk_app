
import 'dart:convert';
import 'dart:typed_data';

  List<String> splitEvery(String string, int chunkSize) {
    List<String> chunks = [];
    for (int i = 0; i < string.length; i += chunkSize) {
      chunks.add(string.substring(i, i + chunkSize));
    }
    return chunks;
  }

class Libro {
  String isbn;
  String titolo;
  String autori;
  String materia;
  String edizione;
  List<int>? copertina;
  int numPagine;

  Libro({
    required this.isbn,
    required this.titolo,
    required this.autori,
    required this.materia,
    required this.edizione,
    this.copertina,
    required this.numPagine,
  });



  factory Libro.fromJson(Map<String, dynamic> json) {
  List<int>? copertina;
  if (json['COPERTINA'] != null) {
    String hexString = json['COPERTINA'];
    copertina = hexString.isNotEmpty
        ? splitEvery(hexString.replaceAll(' ', '').replaceAll('\n', ''), 2)
            .map((e) => int.parse(e, radix: 16))
            .toList()
        : null;
  }

  return Libro(
    isbn: json['ISBN'],
    titolo: json['TITOLO'],
    autori: json['AUTORI'],
    materia: json['MATERIA'],
    edizione: json['EDIZIONE'],
    copertina: copertina,
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
      'COPERTINA': copertina != null ? base64Encode(Uint8List.fromList(copertina!)) : null,
      'NUM_PAGINE': numPagine,
    };
  }

  @override
  String toString() {
    return 'Libro{ISBN: $isbn, TITOLO: $titolo, AUTORI: $autori, MATERIA: $materia, EDIZIONE: $edizione, NUM_PAGINE: $numPagine}';
  }
}