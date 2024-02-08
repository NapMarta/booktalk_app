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
  int? ultfunz1;
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
    //print(json['ultfunz1'].toString());
    return Utente(
      id: json['ID'],
      nome: json['NOME'],
      cognome: json['COGNOME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
      foto: foto,
      ultfunz1: json['ULTFUNZ1'],
      ultfunz2: json['ULTFUNZ2'],
      ultfunz3: json['ULTFUNZ3'],
    );
  }


  factory Utente.fromJson2(Map<String, dynamic> json) {
    List<int>? foto;
    if (json['FOTO'] != null) {
      String base64String = json['FOTO'];
      foto = base64.decode(base64String);
    }

    /*double ultfunz1 = json['ULTFUNZ1'] != null ? (json['ULTFUNZ1'] as num).toDouble() : 0.0;
    double ultfunz2 = json['ULTFUNZ2'] != null ? (json['ULTFUNZ2'] as num).toDouble() : 0.0;
    double ultfunz3 = json['ULTFUNZ3'] != null ? (json['ULTFUNZ3'] as num).toDouble() : 0.0;*/

    
    return Utente(
      id: json['ID'],
      nome: json['NOME'],
      cognome: json['COGNOME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
      foto: foto,
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
      'FOTO': foto != null ? base64Encode(Uint8List.fromList(foto!)) : null,
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
