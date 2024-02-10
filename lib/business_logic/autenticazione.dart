import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/storage/libreriaDAO.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../storage/utente.dart';
import '../storage/utenteDAO.dart';
import 'dart:convert';
import 'autenticazioneService.dart';


class Autenticazione implements AutenticazioneService{
  final String baseUrl;
  UtenteDao _utenteDao = UtenteDao("http://130.61.22.178:9000");
  Utente? utente;
  SharedPreferences? _preferences;
  late MonitoraggioStatistiche monitoraggio = MonitoraggioStatistiche.instance;
  List<Map<String, dynamic>>? libreriaJson;
  LibreriaDao _libreriaDao = LibreriaDao('http://130.61.22.178:9000');



  Autenticazione(this.baseUrl) {
    _utenteDao = UtenteDao(baseUrl);
    _libreriaDao = LibreriaDao(baseUrl);
    _initPreferences();
  }

  Map<String, dynamic> validateParameters(String email, String password){
    
    if (!isValidEmail(email)) {
        return {'error': 'Inserisci un indirizzo email valido'};
    }

    if (!isValidPassword(password)) {
        return {'error': 'La password deve essere lunga almeno 6 caratteri'};
    }
      return {};
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _restoreUtenteFromPreferences();
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    Utente? utente = await _utenteDao.getUtenteByEmailPassword(email, password);

    if (utente != null) {
      this.utente = utente;
      //print("Autenticazione: " + utente.toString());
      monitoraggio = MonitoraggioStatistiche.instance;
      monitoraggio.setUtente(utente);
      if (utente.ultfunz1 != null) 
        monitoraggio.setFunz1(utente.ultfunz1!);
      if (utente.ultfunz2 != null)
        monitoraggio.setFunz2(utente.ultfunz2!);
      if (utente.ultfunz3 != null)
        monitoraggio.setFunz3(utente.ultfunz3!);
      
      print("UTENTE LOGGATO:"+utente.toString());

      libreriaJson = await _libreriaDao.getLibreriaUtenteJson(utente.id!);

      await _saveUtenteToPreferences();

      return {'success': 'Login eseguito con successo'};

    } else {
      print("Errore login");
      return {'error': 'Login non riuscito, credenziali errate'};
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    /*utente?.ultfunz1 = monitoraggio.getFunz1();
    utente?.ultfunz2 = monitoraggio.getFunz2();
    utente?.ultfunz3 = monitoraggio.getFunz3();
    UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
    await dao.updateUtenteFunz(utente!);*/
    utente = null;
    monitoraggio.azzera();
    await _removeUtenteFromPreferences();
    return {'success': 'Logout eseguito con successo'};
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
    return utente;
  }

  @override
  bool get isUtenteAutenticato {
    return utente != null;
  }

  Future<void> _saveUtenteToPreferences() async {
    if (_preferences != null) {
      await _preferences!.setString('utente', json.encode(utente!.toJson()));
      await _preferences!.setString('libreria', json.encode(libreriaJson));
      //printSharedPreferences();
    }
  }


  Future<void> _restoreUtenteFromPreferences() async {
    if (_preferences != null) {
      String? utenteJson = _preferences!.getString('utente');
      if (utenteJson != null && utenteJson.isNotEmpty) {
        Map<String, dynamic> utenteMap = json.decode(utenteJson);
        utente = Utente.fromJson2(utenteMap);
      }
      //printSharedPreferences();
    }
  }

  Future<void> _removeUtenteFromPreferences() async {
    if (_preferences != null) {
      await _preferences!.remove('utente');
      await _preferences!.remove('libreria');
      await _preferences!.clear();
      //print("In _removeUtenteFromPreferences");
      //printSharedPreferences();
      _preferences = null;
    }
  }


}