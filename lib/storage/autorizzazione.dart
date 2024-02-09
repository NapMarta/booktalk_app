class Autorizzazione {
  int? id;
  String? tempoUtilizzato;
  String dataScadenza;
  int? utente;
  String? libro;
  int? numClick;

  Autorizzazione({
    this.id,
    this.tempoUtilizzato,
    required this.dataScadenza,
    this.utente,
    this.libro,
    this.numClick
  });

  factory Autorizzazione.fromJson(Map<String, dynamic> json) {
    return Autorizzazione(
      id: json['ID'],
      tempoUtilizzato: json['TEMPO_UTILIZZATO'],
      dataScadenza: json['DATA_SCADENZA'],
      utente: json['UTENTE'],
      libro: json['LIBRO'],
      numClick: json['NUMCLICK'] != null ? int.parse(json['NUMCLICK']) : 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TEMPO_UTILIZZATO': tempoUtilizzato,
      'DATA_SCADENZA': dataScadenza,
      'UTENTE': utente,
      'LIBRO': libro,
      'NUMCLICK': numClick != null ? numClick.toString() : null
    };
  }

  @override
  String toString() {
    return 'Autorizzazione{id: $id, tempoUtilizzato: $tempoUtilizzato, '
        'dataScadenza: $dataScadenza, utente: $utente, libro: $libro, numClick: $numClick}';
  }
}