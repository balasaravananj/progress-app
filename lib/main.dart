import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:progress_app/percentage_viewer.dart';

void main(){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Progress App",
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dateUtility = new DateUtil();
  double pcnt=-1;

  bool _yearPressed=false;
  bool _monthPressed=false;
  bool _dayPressed =false;

  void showYearPcnt(){
    setState(() {
      _yearPressed=true;
      _monthPressed=false;
      _dayPressed=false;
    });

    int totalDays;
    final daysPassed = dateUtility.daysPastInYear(DateTime.now().month,DateTime.now().day,
                                                      DateTime.now().year)-1;
    if(dateUtility.leapYear(DateTime.now().year)) {
      totalDays = 366;
    }
    else{
      totalDays = 365;
    }
    setState(() {
      pcnt = (daysPassed/totalDays)*100;
    });
  }
  void showMonthPcnt(){

    setState(() {
      _yearPressed=false;
      _monthPressed=true;
      _dayPressed=false;
    });

    int totalDays=dateUtility.daysInMonth(DateTime.now().month, DateTime.now().year);
    int daysPassed = DateTime.now().day-1;
    setState(() {
      pcnt=(daysPassed/totalDays)*100;
    });
  }
  void showDaysPcnt(){
    setState(() {
      _yearPressed=false;
      _monthPressed=false;
      _dayPressed=true;
    });
    int totalHour =24;
    int currentTime = DateTime.now().hour;
    setState(() {
      pcnt = (currentTime/totalHour)*100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress App'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Container(
              height: 500,
              width: double.infinity,
              child: Card(
                elevation: 5,
                  child: pcnt==-1?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nothing to Show !',
                      style: TextStyle(fontSize: 20),),
                    ],
                  ):
                      PercentageViewer(pcnt),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          color:_yearPressed ?Colors.blue:Colors.black,
                          icon:Icon(Icons.accessible),
                          onPressed:()=>showYearPcnt(),),
                        Text(
                          'Year',
                          style: TextStyle(
                            color: _yearPressed ?Colors.blue:Colors.black,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          color: _monthPressed ?Colors.blue:Colors.black,
                          icon: Icon(Icons.accessibility),
                          onPressed:()=>showMonthPcnt() ,),
                        Text('Month',style: TextStyle(
                            color: _monthPressed ?Colors.blue:Colors.black,
                            fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          color:_dayPressed ?Colors.blue:Colors.black,
                          icon: Icon(Icons.run_circle),
                          onPressed:()=>showDaysPcnt() ,),
                        Text('Day',style: TextStyle(
                            color: _dayPressed ?Colors.blue:Colors.black,
                            fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

