class Autorizzazione {
  int? id;
  String? tempoUtilizzato; // Cambiato il tipo in String
  String dataScadenza; // Cambiato il tipo in String
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
      tempoUtilizzato: json['TEMPO_UTILIZZATO'],
      dataScadenza: json['DATA_SCADENZA'],
      utente: json['UTENTE'],
      libro: json['LIBRO'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TEMPO_UTILIZZATO': tempoUtilizzato,
      'DATA_SCADENZA': dataScadenza,
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