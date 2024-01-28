import '../storage/utente.dart';

abstract class RegistrazioneService {
  Map<String, dynamic> validateParameters(Utente utente, String confermaPassword);
  Future<Map<String, dynamic>> registrati(Utente utente, String confermaPassword);
}