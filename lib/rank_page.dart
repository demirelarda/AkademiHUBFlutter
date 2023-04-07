import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  Map<String, List<Object>> myList = {
    "Yusuf": [1000, "Flutter"],
    "Arda": [2000, "Unity"],
    "Selin": [3000, "Flutter"],
    "Berat": [5000, "Unity"],
    "Sevcan": [6000, "Flutter"]
  };

  @override
  Widget build(BuildContext context) {
    var newList = myList.entries.toList();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height / 3.5,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 34, 38, 62),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                    ),
                    Text(
                      "İsim",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Puan",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                  ),
                  Text(
                    "İsim",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Puan",
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  Text(
                    "İsim",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Puan",
                    style: TextStyle(color: Colors.white),
                  )
                ])
              ],
            ),
          ),
          ListView.builder(
              itemCount: myList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Color.fromARGB(255, 34, 38, 62),
                  ),
                  trailing:
                  myList.values.toList()[index][1] == "Flutter"
                      ? ImageIcon(AssetImage("images/flutter-icon.png"))
                      : ImageIcon(AssetImage("images/unity-icon.png")),
                  title: Text("${myList.values.toList()[index][0]}     ${myList.keys.toList()[index]}"),
                );
              })
        ],
      ),
    );
  }
}
