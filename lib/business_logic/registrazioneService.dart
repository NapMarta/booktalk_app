import '../storage/utente.dart';

abstract class RegistrazioneService {
  Map<String, dynamic> validateParameters(Utente utente, String confermaPassword);
  Future<Map<String, dynamic>> registrati(Utente utente, String confermaPassword);
  Map<String, dynamic> validateParametersModifica (Utente utente, String nome, String cognome, String passwordAttuale, String nuovaPassword);
  Future<Map<String, dynamic>> modificaUtente (Utente utente);
  Future<Map<String, dynamic>> modificaProfiloUtente (Utente utente, bool password);
  Future<Map<String, dynamic>> modificaUtenteNoPassword (Utente utente);
}