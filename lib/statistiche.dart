import 'dart:typed_data';

import 'package:booktalk_app/business_logic/monitoraggioStatistiche.dart';
import 'package:booktalk_app/storage/libro.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({Key? key}) : super(key: key);

  @override
  _StatisticheState createState() => _StatisticheState();
  
}

class _StatisticheState extends State<Statistiche> {

  late SharedPreferences _preferences;
  //late Future<Utente?> utente;
  double utlFunz1 = 0.0, utlFunz2 = 0.0, utlFunz3 = 0.0;
  Uint8List copertina1 = Uint8List(0);
  Uint8List copertina2 = Uint8List(0);
  Uint8List copertina3 = Uint8List(0);
  bool dataLoaded = false, top3NotExist = false;
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  // Funzione per caricare i dati dell'utente dalle SharedPreferences
  Future<void> _loadUserData() async {
    //print("Loading user data...");
    _preferences = await SharedPreferences.getInstance();
    String utenteJson = _preferences.getString('utente') ?? '';
    if (utenteJson.isNotEmpty) {
      //Map<String, dynamic> utenteMap = json.decode(utenteJson);
      MonitoraggioStatistiche monitoraggioStatistiche = MonitoraggioStatistiche.instance;
      //print(monitoraggioStatistiche.getPercentualeF1().toString());
      utlFunz1 = monitoraggioStatistiche.getPercentualeF1();
      utlFunz2 = monitoraggioStatistiche.getPercentualeF2();
      utlFunz3 = monitoraggioStatistiche.getPercentualeF3();

      /*utlFunz1 = double.parse(utenteMap['ULTFUNZ1']);
      utlFunz2 = double.parse(utenteMap['ULTFUNZ2']);
      utlFunz3 = double.parse(utenteMap['ULTFUNZ3']);*/

      List<Libro> top3 = await monitoraggioStatistiche.getTopThreeLibri();
      if(top3.length == 3){
        copertina1 = Uint8List.fromList(top3[0].copertina!);
        copertina2 = Uint8List.fromList(top3[1].copertina!);
        copertina3 = Uint8List.fromList(top3[2].copertina!);
      }else{
        top3NotExist = true;
      }

      dataLoaded = true;

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTabletOrizzontale(mediaQueryData) ? mediaQueryData.size.height * 0.1 : mediaQueryData.size.height * 0.07),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0097b2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: mediaQueryData.size.height * 0.006),
              Image.asset(
                "assets/linea.png",
                width: 50,
              ),
              SizedBox(height: mediaQueryData.size.height * 0.013),
              Text(
                'Statistiche',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              //SizedBox(height: 2),
            ],
          ),
        ),
      ),

      //backgroundColor: Colors.white,
      body: dataLoaded ?
      MultiSplitView(
        axis: (mediaQueryData.orientation == Orientation.landscape) ? Axis.horizontal : Axis.vertical,
        resizable: false, // non modifica la dimensione dell'elemento manualmente
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, isTablet(mediaQueryData) ? 10 : 8, 10, 0),
            child: Column(
              mainAxisAlignment: isTabletVerticale(mediaQueryData) ? MainAxisAlignment.start : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isTabletVerticale(mediaQueryData) ? 10 : 0,),
                Text(
                  "Libri più utilizzati", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
                
                (top3NotExist) 
                ? Text(
                    "I tuoi tre libri più utilizzati non sono disponibili!", 
                    style: TextStyle(fontSize: 14,), 
                    textAlign: TextAlign.center,
                  )
                
                : Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.0,
                  runSpacing: 20.0,
                  children: [ 
                    SizedBox(
                      width: isTablet(mediaQueryData) ? 180 : 160,
                      child: _NumberCardWidget(
                        1, // TALE INDICE INDICA LA PRIMA FUNZIONALITA'
                        //"assets/copertina.jpg",
                        copertina1,
                        mediaQueryData
                      ),
                    ),

                    SizedBox(
                      width: isTablet(mediaQueryData) ? 180 : 160,
                      child: _NumberCardWidget(
                        2, // TALE INDICE INDICA LA SECONDA FUNZIONALITA'
                        //"assets/copertina.jpg",
                        copertina2,
                        mediaQueryData
                      ),
                    ),

                    SizedBox(
                      width: isTablet(mediaQueryData) ? 180 : 160,
                      child: _NumberCardWidget(
                        3, // TALE INDICE INDICA LA TERZA FUNZIONALITA'
                        //"assets/copertina.jpg",
                        copertina3,
                        mediaQueryData
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, isTablet(mediaQueryData) ? 75 : 15),
            child: Column(
              mainAxisAlignment: isTabletVerticale(mediaQueryData) ? MainAxisAlignment.start : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Percentuale di utilizzo delle funzionalità", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), 
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: isTablet(mediaQueryData) ? 230 : 210,
                  height: isTablet(mediaQueryData) ? 230 : 210,
                  child: 
                    /* 
                    (funz1 == 0 && funz2 == 0 && funz3 == 0) 
                    ? Text(
                        "Non hai ancora utilizzato le funzionalità dell'app", 
                        style: TextStyle(fontSize: 14,), 
                        textAlign: TextAlign.center,
                      ),
                    : */
                    PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        centerSpaceRadius: double.infinity,
                        sections: _pieChartData(
                          utlFunz1, // funzionalità 1
                          utlFunz2, // funzionalità 2
                          utlFunz3, // funzionalità 3
                        ),
                      ),
                      swapAnimationDuration: Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                ),
              ],
            ),
          ),
        ],
      )
    : Center(child: CircularProgressIndicator(color: Color(0xFF0097b2))),
    );
  }
}

List<PieChartSectionData> _pieChartData(
  double funz1,
  double funz2,
  double funz3,
) {
  return [
    PieChartSectionData(
      color: Color.fromARGB(160, 240, 189, 94),
      value: funz1,
      title: '${funz1}%',
      radius: 100,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
      ),
      badgeWidget: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        padding: EdgeInsets.all(5),
        child: Center(
          child: Image.asset(
            'assets/1.png',
            width: 40,
          ),
        ),
      ),
      badgePositionPercentageOffset: 1.1,
    ),
    PieChartSectionData(
      color: Color.fromARGB(160, 5, 168, 186),
      value: funz2,
      title: '${funz2}%',
      radius: 100,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
      ),
      badgeWidget: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        padding: EdgeInsets.all(5),
        child: Center(
          child: Image.asset(
            'assets/2.jpeg',
            width: 40,
          ),
        ),
      ),
      badgePositionPercentageOffset: 1.1,
    ),
    PieChartSectionData(
      color: Color.fromARGB(160, 255, 60, 42),
      value: funz3,
      title: '${funz3}%',
      radius: 100,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
      ),
      badgeWidget: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        padding: EdgeInsets.all(5),
        child: Center(
          child: Image.asset(
            'assets/funzionalità3.jpg',
            width: 42,
          ),
        ),
      ),
      badgePositionPercentageOffset: 1.1,
    ),
  ];
}



// --- ELEMENTO NELLA TOP 3 LIBRI ---
Widget _NumberCardWidget(int index, Uint8List copertina, var mediaQueryData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.5),
    child: Stack(
      children: [
        Positioned(
            left: 13,
            bottom: 0,
            child: Center(
              child: Image.asset(
                "assets/top${index}.png",
                width: 60,
              ),
            ),
        ),

        Row(
          children: [
            const SizedBox(
              height: 40,
              width: 60,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.memory(
                copertina,
                width: isTablet(mediaQueryData) ? 100 : 80,
                height: isTablet(mediaQueryData) ? 150 : 130,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
