
import 'package:shared_preferences/shared_preferences.dart';

abstract class GestioneAutorizzazioniService {
  Future <Map<String, dynamic>> addAutorizzazione(String isbn, int id, SharedPreferences preferences);
  //Future<bool> isAutorizzazioneScaduta(String isbn, int id);
}