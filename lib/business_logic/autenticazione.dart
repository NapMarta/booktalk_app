import 'package:shared_preferences/shared_preferences.dart';
import '../storage/utente.dart';
import '../storage/utenteDAO.dart';
import 'dart:convert';
import 'autenticazioneService.dart';


class Autenticazione implements AutenticazioneService{
  UtenteDao _utenteDao;
  Utente? utente;
  SharedPreferences? _preferences;

  Autenticazione(this._utenteDao) {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _restoreUtenteFromPreferences();
  }

  @override
  Future<bool> login(String email, String password) async {
    Utente? utente = await _utenteDao.getUtenteByEmailPassword(email, password);

    if (utente != null) {
      this.utente = utente;
      //print("Autenticazione: " + utente.toString());
      await _saveUtenteToPreferences();

      return true;
    } else {
      print("Errore login");
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    this.utente = null;
    await _removeUtenteFromPreferences();
    return true;
  }

  void printSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Set<String> keys = preferences.getKeys();

    for (String key in keys) {
      print('Shared preferences: $key: ${preferences.get(key)}');
    }
  }

  @override
  Utente? getUtenteCorrente() {
    return this.utente;
  }

  @override
  bool get isUtenteAutenticato {
    return this.utente != null;
  }

  Future<void> _saveUtenteToPreferences() async {
  if (_preferences != null) {
    await _preferences!.setString('utente', json.encode(utente!.toJson()));
    //printSharedPreferences();
  }
}

  Future<void> _restoreUtenteFromPreferences() async {
    if (_preferences != null) {
      String? utenteJson = _preferences!.getString('utente');
      if (utenteJson != null && utenteJson.isNotEmpty) {
        Map<String, dynamic> utenteMap = json.decode(utenteJson);
        this.utente = Utente.fromJson(utenteMap);
      }
    }
  }

  Future<void> _removeUtenteFromPreferences() async {
    if (_preferences != null) {
      await _preferences!.setString('utente', json.encode(utente!.toJson()));
      await _preferences!.clear();
      //printSharedPreferences();
      this._preferences=null;
    }
  }

}