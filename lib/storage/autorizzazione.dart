class Autorizzazione {
  int? id;
  DateTime? tempoUtilizzato;
  DateTime dataScadenza;
  int? utente;
  String? libro;

  Autorizzazione({
    this.id,
    this.tempoUtilizzato,
    required this.dataScadenza,
    this.utente,
    this.libro,
  });

  factory Autorizzazione.fromJson(Map<String, dynamic> json) {
    return Autorizzazione(
      id: json['ID'],
      tempoUtilizzato: json['TEMPO_UTILIZZATO'] != null
          ? DateTime.parse(json['TEMPO_UTILIZZATO'])
          : null,
      dataScadenza: DateTime.parse(json['DATA_SCADENZA']),
      utente: json['UTENTE'],
      libro: json['LIBRO'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TEMPO_UTILIZZATO': tempoUtilizzato?.toIso8601String(),
      'DATA_SCADENZA': dataScadenza.toIso8601String(),
      'UTENTE': utente,
      'LIBRO': libro,
    };
  }

  @override
  String toString() {
    return 'Autorizzazione{id: $id, tempoUtilizzato: $tempoUtilizzato, '
        'dataScadenza: $dataScadenza, utente: $utente, libro: $libro}';
  }
}
