
class MonitoraggioStatistiche {
  double funz1 = 1.0, funz2 = 1.0, funz3 = 1.0;

  // Singola istanza della classe
  static MonitoraggioStatistiche? _instance;

  // Costruttore privato
  MonitoraggioStatistiche._();

  // Metodo per ottenere l'istanza singleton
  static MonitoraggioStatistiche get instance {
    _instance ??= MonitoraggioStatistiche._(); // Creare l'istanza se non esiste già
    return _instance!;
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

  void incrementaFunz1(double f1){
    funz1++;
  }

  void incrementaFunz2(double f2){
    funz2++;
  }

  void incrementaFunz3(double f3){
    funz3++;
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
    funz1 = 1.0;
    funz2 = 1.0;
    funz3 = 1.0;
  }
  
}

  