
import 'dart:convert';

import 'package:booktalk_app/storage/autorizzazioneDAO.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:booktalk_app/storage/utente.dart';
import 'package:booktalk_app/storage/utenteDAO.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitoraggioStatistiche {
  double funz1 = 0.0, funz2 = 0.0, funz3 = 0.0;
  late Utente utente;
  UtenteDao dao = UtenteDao('http://130.61.22.178:9000');
  AutorizzazioneDao autorizzazioneDao = AutorizzazioneDao('http://130.61.22.178:9000');
  late SharedPreferences _preferences;

  // Singola istanza della classe
  static MonitoraggioStatistiche? _instance;

  // Costruttore privato
  MonitoraggioStatistiche._();

  // Metodo per ottenere l'istanza singleton
  static MonitoraggioStatistiche get instance {
    _instance ??= MonitoraggioStatistiche._(); // Creare l'istanza se non esiste già
    return _instance!;
  }

  Future<void> setUtente(Utente utente) async {
    this.utente= utente;
    _preferences = await SharedPreferences.getInstance();
  }

  double getFunz1(){
    return funz1;
  }

  double getFunz2(){
    return funz1;
  }

  double getFunz3(){
    return funz1;
  }

  void setFunz1(double f1){
    funz1 = f1;
  }

  void setFunz2(double f2){
    funz2 = f2;
  }

  void setFunz3(double f3){
    funz3 = f3;
  }

  Future<void> incrementaFunz1() async {
    funz1++;
    utente.ultfunz1 = funz1;
    dao.updateUtenteFunz(utente);
    await _preferences!.setString('utente', json.encode(utente.toJson()));
  }

  Future<void> incrementaFunz2() async {
    funz2++;
    utente.ultfunz2 = funz2;
    dao.updateUtenteFunz(utente);
    await _preferences!.setString('utente', json.encode(utente.toJson()));
  }

  Future<void> incrementaFunz3() async {
    funz3++;
    utente.ultfunz3 = funz3;
    dao.updateUtenteFunz(utente);
    await _preferences!.setString('utente', json.encode(utente.toJson()));
  }

  double getPercentualeF1(){
    double tot = funz1+funz2+funz3;
    double temp = funz1*100/tot;
    int numeroDiCifreDecimali = 2;
    String numeroArrotondatoStringa = temp.toStringAsFixed(numeroDiCifreDecimali);
    double numeroArrotondato = double.parse(numeroArrotondatoStringa);
    return numeroArrotondato;
  }

  double getPercentualeF2(){
    double tot = funz1+funz2+funz3;
    double temp = funz2*100/tot;
    int numeroDiCifreDecimali = 2;
    String numeroArrotondatoStringa = temp.toStringAsFixed(numeroDiCifreDecimali);
    double numeroArrotondato = double.parse(numeroArrotondatoStringa);
    return numeroArrotondato;
  }

  double getPercentualeF3(){
    double tot = funz1+funz2+funz3;
    double temp = funz3*100/tot;
    int numeroDiCifreDecimali = 2;
    String numeroArrotondatoStringa = temp.toStringAsFixed(numeroDiCifreDecimali);
    double numeroArrotondato = double.parse(numeroArrotondatoStringa);
    return numeroArrotondato;
  }

  void azzera(){
    funz1 = 0.0;
    funz2 = 0.0;
    funz3 = 0.0;
  }

  Future<bool> aggiungiClickLibro(String isbn) async {

    try{

      final response = await autorizzazioneDao.updateAutorizzazioneClick(utente.id!, isbn);

      if (response.containsKey('error'))
        return false;

      else 
        return true;

    } catch (e) {
      print("Eccezione in business_logic/monitoraggioStatistiche.dart: $e");
      return false;
    }

  }

  Future<List<Libro>> getTopThreeLibri () async {

    try{

      List<Libro> top3 = await autorizzazioneDao.getTopThree(utente.id!);
      
      return top3;

    } catch (e) {
      print("Eccezione in business_logic/monitoraggioStatistiche.dart: $e");
      return [];
    }

  }
  
}

  