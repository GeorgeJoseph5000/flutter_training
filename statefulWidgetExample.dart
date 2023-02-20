import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: !isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.blue : Color(0xffEECED3),
      highlightColor: isDarkTheme
          ? Color.fromARGB(255, 1, 32, 55)
          : Color.fromARGB(255, 146, 206, 252),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.blueAccent),
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Styles.themeData(true, context),
      home: MyHomePage(),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final TimeOfDay timeOfDay;
  final DateTime dateTime;
  
  const ProfileCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.timeOfDay,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(7),
            child: Stack(
              alignment: const Alignment(0.6, 0.6),
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 70,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(timeOfDay.format(context)),
              Text(dateTime.day.toString() + "/" + dateTime.month.toString() + "/" + dateTime.year.toString()),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 4,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String name = "Beast";
  String imageUrl =
      "https://pbs.twimg.com/profile_images/994592419705274369/RLplF55e_400x400.jpg";
  TimeOfDay timeInDay = TimeOfDay(hour: 0, minute: 0);
  DateTime date = DateTime.now();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showvalue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Flutter App")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        TextFormField(
          decoration: InputDecoration(
              label: Text("Name"), prefixIcon: Icon(Icons.person)),
          onChanged: (value) {
            setState(() {
              widget.name = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
              label: Text("Image Url"), prefixIcon: Icon(Icons.cloud)),
          onChanged: (value) {
            setState(() {
              widget.imageUrl = value;
            });
          },
        ),
        SizedBox(
          height: 50,
        ),
        ProfileCard(
            imageUrl: widget.imageUrl,
            name: widget.name,
            timeOfDay: widget.timeInDay,
            dateTime: widget.date),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 0, minute: 0),
                      );
                      setState(() {
                        if (newTime != null) {
                          widget.timeInDay = newTime;
                        }
                      });
                      print(newTime);
                    },
                    child: Text("Choose Time")),
                Center(
                    child: Text(widget.timeInDay.toString() == "null"
                        ? ""
                        : widget.timeInDay.format(context))),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        initialDate: DateTime.now(),
                        context: context, firstDate: DateTime(1990), lastDate: DateTime(2029),
                      );
                      setState(() {
                        if (newDate != null) {
                          widget.date = newDate;
                        }
                      });
                      print(newDate);
                    },
                    child: Text("Choose Date")),
                Center(
                    child: Text(widget.date.toString() == "null"
                        ? ""
                        : widget.date.day.toString() + "/" + widget.date.month.toString() + "/" + widget.date.year.toString())),
              ],
            ),
            
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Wrap(children: [
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share'),
                    ),
                    ListTile(
                      leading: Icon(Icons.copy),
                      title: Text('Copy Link'),
                    ),
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ]));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
