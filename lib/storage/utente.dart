import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

List<String> splitEvery(String string, int chunkSize) {
  List<String> chunks = [];
  for (int i = 0; i < string.length; i += chunkSize) {
    chunks.add(string.substring(i, i + chunkSize));
  }
  return chunks;
}

class Utente {
  int? id;
  String nome;
  String cognome;
  String email;
  String password;
  List<int>? foto;
  double? ultfunz1;
  double? ultfunz2;
  double? ultfunz3;

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
    List<int>? foto;
    if (json['FOTO'] != null) {
      String hexString = json['FOTO'];
      foto = hexString.isNotEmpty
          ? splitEvery(hexString.replaceAll(' ', '').replaceAll('\n', ''), 2)
              .map((e) => int.parse(e, radix: 16))
              .toList()
          : null;
    }

    //print('JSON: $json');

    double u1 = json['ultfunz1'] != null ? double.parse(json['ultfunz1']) : 0.0;
    double u2 = json['ultfunz2'] != null ? double.parse(json['ultfunz2']) : 0.0;
    double u3 = json['ultfunz3'] != null ? double.parse(json['ultfunz3']) : 0.0;

    //print("VARIABILI "+ u1.toString() +  u2.toString() + u3.toString());

    return Utente(
      id: json['ID'],
      nome: json['NOME'],
      cognome: json['COGNOME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
      foto: foto,
      ultfunz1: u1,
      ultfunz2: u2,
      ultfunz3: u3,
    );
  }


  factory Utente.fromJson2(Map<String, dynamic> json) {
    List<int>? foto;
    if (json['FOTO'] != null) {
      String base64String = json['FOTO'];
      foto = base64.decode(base64String);
    }

    double u1 = json['ultfunz1'] != null ? double.parse(json['ultfunz1']) : 0.0;
    double u2 = json['ultfunz2'] != null ? double.parse(json['ultfunz2']) : 0.0;
    double u3 = json['ultfunz3'] != null ? double.parse(json['ultfunz3']) : 0.0;

    
    return Utente(
      id: json['ID'],
      nome: json['NOME'],
      cognome: json['COGNOME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
      foto: foto,
      ultfunz1: u1,
      ultfunz2: u2,
      ultfunz3: u3,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'NOME': nome,
      'COGNOME': cognome,
      'EMAIL': email,
      'PASSWORD': password,
      'FOTO': foto != null ? base64Encode(Uint8List.fromList(foto!)) : null,
      'ULTFUNZ1': ultfunz1 != null ? ultfunz1.toString() : null,
      'ULTFUNZ2': ultfunz2 != null ? ultfunz2.toString() : null,
      'ULTFUNZ3': ultfunz3 != null ? ultfunz3.toString() : null,
    };
  }

  @override
  String toString() {
    return 'Utente{id: $id, nome: $nome, cognome: $cognome, email: $email, password: $password, ultfunz1: $ultfunz1, ultfunz2: $ultfunz2, ultfunz3: $ultfunz3}';
  }
}
