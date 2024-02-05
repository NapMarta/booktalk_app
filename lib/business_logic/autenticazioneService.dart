import '../storage/utente.dart';

abstract class AutenticazioneService {
  Future <Map<String, dynamic>> login(String email, String password);
  Future <Map<String, dynamic>> logout();
  Utente? getUtenteCorrente();
  bool get isUtenteAutenticato;
  Map<String, dynamic> validateParameters(String email, String password);
}