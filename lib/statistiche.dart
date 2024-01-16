import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

import 'utils.dart';

class Statistiche extends StatefulWidget {
  const Statistiche({Key? key}) : super(key: key);

  @override
  _StatisticheState createState() => _StatisticheState();
}

class _StatisticheState extends State<Statistiche> {
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
      body: MultiSplitView(
        axis: (mediaQueryData.orientation == Orientation.landscape) ? Axis.horizontal : Axis.vertical,
        resizable: false, // non modifica la dimensione dell'elemento manualmenteqq
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, isTablet(mediaQueryData) ? 50 : 8, 10, 0),
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
                /*
                (book1 == null && book2 == null && book3 == null) 
                ? Text(
                    "Non hai libri nella libreria", 
                    style: TextStyle(fontSize: 14,), 
                    textAlign: TextAlign.center,
                  ),
                */
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.0,
                  runSpacing: 20.0,
                  children: [ 
                    SizedBox(
                      width: 180,
                      child: _NumberCardWidget(
                        1, // TALE INDICE INDICA LA PRIMA FUNZIONALITA'
                        "assets/copertina.jpg",
                        mediaQueryData.size.width,
                        mediaQueryData.size.height
                      ),
                    ),

                    SizedBox(
                      width: 180,
                      child: _NumberCardWidget(
                        2, // TALE INDICE INDICA LA SECONDA FUNZIONALITA'
                        "assets/copertina.jpg",
                        mediaQueryData.size.width,
                        mediaQueryData.size.height
                      ),
                    ),

                    SizedBox(
                      width: 180,
                      child: _NumberCardWidget(
                        3, // TALE INDICE INDICA LA TERZA FUNZIONALITA'
                        "assets/copertina.jpg",
                        mediaQueryData.size.width,
                        mediaQueryData.size.height
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(10, isTablet(mediaQueryData) ? 0 : 20, 10, 15),
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
                          18.5, // funzionalità 1
                          31.5, // funzionalità 2
                          50, // funzionalità 3
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
      ),
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
Widget _NumberCardWidget(int index, String imageLibro, double width, double height) {
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
              child: Image.asset(
                "assets/copertina.jpg",
                width: 100,
              ),
            ),
          ],
        ),
        
      ],
    ),
  );
}
