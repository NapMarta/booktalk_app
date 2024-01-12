import '../storage/utente.dart';

abstract class AutenticazioneService {
  Future<bool> login(String email, String password);
  Future<bool> logout();
  Utente? getUtenteCorrente();
  bool get isUtenteAutenticato;
}