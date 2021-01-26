import 'package:flutter/material.dart';
import 'package:LPI_water_annimation/allScreen/settings.dart';
import 'package:LPI_water_annimation/allScreen/about.dart';
import 'package:LPI_water_annimation/allScreen/account.dart';
import 'package:LPI_water_annimation/allScreen/tankManual.dart';
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';


class SliderPage extends StatefulWidget {
  static const String idScreen = "Slider";
  @override
  _SliderPageState createState() => new _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //title: Text("LPI water animation"),
        title: Image.asset('images/logo.png', fit: BoxFit.fill),
        elevation: 0.0,/*, backgroundColor: Colors.teal*/
        //toolbarHeight: 50,
      ),



      body: TankManual(),


      drawer: new Drawer(
        child: ListView(

          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('@'+'Prasanjit'),
              accountEmail: new Text('ps.ee.1846@gmail.com'),

              currentAccountPicture: Image(
                image: AssetImage("images/logo.png"),
                //width: 420.0,
                //height: 250.0,
                alignment: Alignment.center,
              ),

            ),
            new ListTile(
              title: new Text('Account'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Account()));
              },
              leading: const Icon(Icons.perm_identity),
            ),
            new ListTile(
              title: new Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Settings()));
              },
              leading: const Icon(Icons.settings),
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              title: new Text('About Us'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
              //leading: const Icon(Icons.support_agent),
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
