import 'package:fecthjocks/helpers/jocks_api_helper.dart';
import 'package:fecthjocks/model/jocks_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController joksEditingController = TextEditingController();
  TextEditingController timeEditingController = TextEditingController();

  List<Joks> jokesList = [];

  var storedTimes;

  covidcontry() async {
    //CovidData.covidData.fetchWorldData(contry: dropdownvalue);
     await JockData.joksData.fetchWorldData();
  }

  @override
  void initState() {
    super.initState();
  }

  List<String>alldata = [];
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("joks data"), actions: [IconButton(onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {return AlertDialog(content:  Container(
height: 500,width: 300,
            child: ListView.builder(
              itemCount: jokesList.length ,
              itemBuilder: (context, position) {
                Joks joks = Joks();

                joks = jokesList[position];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Jocks: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: "${joks.value},\n",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: "date: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),TextSpan(
                              text: joks.createddate,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),);});
        },
          icon: Icon(Icons.add, color: Colors.black,),)
        ],
        ),
        body: FutureBuilder(
            future: JockData.joksData.fetchWorldData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                Joks data = snapshot.data;

                //alldata.add("${data.createddate!.split(" ")[1]}");
                print("-------------------------------------------");
                print(alldata);
                return SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'date: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${data.createddate!.split(" ")[0]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Time: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${data.createddate!.split(" ")[1]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Jocks: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${data.value}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: ()  {
                             setState(()  {
                                covidcontry();
                             });



                            },
                            child: Container(
                              height: 50,
                              width: 130,

                              child: Center(

                                child: Text("new jocks"),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 9,
                                        offset: Offset(3.4, 2.4))
                                  ]),
                            ),
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () async {
                              setState(() {


                                Joks joke = Joks(createddate: data.createddate, value: data.value) ;

                                jokesList.add(joke);
                              });
                              setState((){});

                              final prefs = await SharedPreferences.getInstance();

                              //prefs.setStringList("jokesString",jokesList );

                            },
                            child: Container(
                              height: 50,
                              width: 130,

                              child: Center(

                                child: Text("Fetch My Laugh"),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 9,
                                        offset: Offset(3.4, 2.4))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

// _save() async {
//   // final prefs = await SharedPreferences.getInstance();
//   // final key = 'my_int_key';
//   //
//   // prefs.setString(key, "${date}");
//   // print('saved $value');
//
// });
// }