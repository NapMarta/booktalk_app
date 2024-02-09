import '../storage/utente.dart';

abstract class GestioneAutorizzazioniService {
  Future <Map<String, dynamic>> addAutorizzazione(String isbn, int id);
  Future<bool> isAutorizzazioneScaduta(String isbn, int id);
}