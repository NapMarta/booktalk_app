import 'dart:convert';

import 'package:booktalk_app/business_logic/registrazioneService.dart';
import 'package:booktalk_app/storage/libreria.dart';
import 'package:booktalk_app/storage/libreriaDAO.dart';
import 'package:booktalk_app/storage/utente.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registrazione implements RegistrazioneService{
  final String baseUrl;
  final UtenteDao utenteDao;

  Registrazione(this.baseUrl) : utenteDao = UtenteDao(baseUrl);

  Map<String, dynamic> validateParameters(Utente utente, String confermaPassword){
    
    if (utente.password == confermaPassword){

      if (utente.nome.length <1)
        return {'error': 'Inserisci un nome valido'};

      if (utente.cognome.length <1)
        return {'error': 'Inserisci un cognome valido'};

      if (!isValidEmail(utente.email)) {
        return {'error': 'Inserisci un indirizzo email valido'};
      }

      if (!isValidPassword(utente.password)) {
        return {'error': 'La password deve essere lunga almeno 6 caratteri'};
      }
      return {};
    }
    else {
      return{'error': 'Le password inserite non coincidono'};
    }
  }

 bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<Map<String, dynamic>> registrati(Utente utente, String confermaPassword) async {
    try {
      // Validazione dei parametri
      final validationError = validateParameters(utente, confermaPassword);
      if (validationError.isNotEmpty) {
        return validationError;
      }

      // Controlla se l'utente esiste già
      final existingUser = await utenteDao.getUtenteByEmail(utente.email);
      if (existingUser != null) {
        return {'error': 'Email già registrata.'};
      }

      utente.foto ??= null;
      utente.ultfunz1 ??= null;
      utente.ultfunz2 ??= null;
      utente.ultfunz3 ??= null;

      var response = await utenteDao.insertUtente(utente);

      utente = (await utenteDao.getUtenteByEmail(utente.email))!;

      if (response.containsKey('error')) {
        return {'error': 'Errore durante la registrazione.'};
      } else {
        utente = (await utenteDao.getUtenteByEmail(utente.email))!;
        print(response);
        LibreriaDao dao = LibreriaDao(baseUrl);
        await dao.insertLibreria(Libreria(utente: utente.id!, numLibri: 0));
        print("success registrazione");
        return {'success': 'Registrazione avvenuta con successo.'};
      }
    } catch (e) {
      print('Errore durante la registrazione: $e');
      return {'error': 'Errore durante la registrazione.'};
    }
  }
  
  @override
  Future<Map<String, dynamic>> modificaUtente(Utente utente) async {
    //UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
    try{
      final response = await utenteDao.updateUtente(utente);

      if (response.containsKey('error')) {
        print(response);
        return response;

      } else {
        var bytes = utf8.encode(utente.password);
        var hashed = sha256.convert(bytes);
        String hashedPassword = hashed.toString();
        utente.password= hashedPassword;
        SharedPreferences _preferences = await SharedPreferences.getInstance();
        await _preferences.remove('utente');
        await _preferences.setString('utente', json.encode(utente.toJson()));
        print("success modifica");
        return {'success': 'Modifica avvenuta con successo.'};
      }
    } catch (e) {
      print('Errore durante la modifica: $e');
      return {'error': 'Errore durante la modifica.'};
    }
  }

  @override
  Future<Map<String, dynamic>> modificaProfiloUtente(Utente utente, bool password) async {
    //UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
    try{
      final response = await utenteDao.updateProfiloUtente(utente, password);

      if (response.containsKey('error')) {
        print(response);
        return response;

      } else {
        var bytes = utf8.encode(utente.password);
        var hashed = sha256.convert(bytes);
        String hashedPassword = hashed.toString();
        utente.password= hashedPassword;
        SharedPreferences _preferences = await SharedPreferences.getInstance();
        await _preferences.remove('utente');
        await _preferences.setString('utente', json.encode(utente.toJson()));
        print("success modifica");
        return {'success': 'Modifica avvenuta con successo.'};
      }
    } catch (e) {
      print('Errore durante la modifica: $e');
      return {'error': 'Errore durante la modifica.'};
    }
  }

  @override
  Future<Map<String, dynamic>> modificaUtenteNoPassword(Utente utente) async {
    //UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
    try{
      final response = await utenteDao.updateUtenteNoEncode(utente);

      if (response.containsKey('error')) {
        print(response);
        return response;

      } else {
        var bytes = utf8.encode(utente.password);
        var hashed = sha256.convert(bytes);
        String hashedPassword = hashed.toString();
        utente.password= hashedPassword;
        SharedPreferences _preferences = await SharedPreferences.getInstance();
        await _preferences.remove('utente');
        await _preferences.setString('utente', json.encode(utente.toJson()));
        print("success modifica");
        return {'success': 'Modifica avvenuta con successo.'};
      }
    } catch (e) {
      print('Errore durante la modifica: $e');
      return {'error': 'Errore durante la modifica.'};
    }
  }
  
  @override
  Map<String, dynamic> validateParametersModifica(Utente utente, String nome, String cognome, String passwordAttuale, String nuovaPassword) {
    
    if (nome.isEmpty && cognome.isEmpty && passwordAttuale.isEmpty && nuovaPassword.isEmpty) {
      return {'error': 'Inserisci almeno un valore da modificare'};
    }

    if(passwordAttuale.isNotEmpty && nuovaPassword.isNotEmpty){
    
      if (!isValidPassword(passwordAttuale)) {
        return {'error': 'La password attuale è errata'};
      }

      if (!isValidPassword(nuovaPassword)) {
        return {'error': 'La password deve essere lunga almeno 6 caratteri'};
      }

      var bytes = utf8.encode(passwordAttuale);
      var hashed = sha256.convert(bytes);
      String hashedPassword = hashed.toString();
      if (utente.password != hashedPassword) {
        return {'error': 'La password attuale inserita è errata'};
      }
      else{
        return {};
      }
    
    }
    else if (passwordAttuale.isEmpty && nuovaPassword.isEmpty){
      return{};
    }
    else{
      return {'error': 'La password deve essere lunga almeno 6 caratteri'};
    }
  }
}
