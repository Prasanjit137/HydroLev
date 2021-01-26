import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LPI_water_annimation/mqtt/state/MQTTAppState.dart';
import 'package:LPI_water_annimation/mqtt/MQTTManager.dart';
import 'package:LPI_water_annimation/allScreen/settings.dart';
import 'package:LPI_water_annimation/allScreen/about.dart';
import 'package:LPI_water_annimation/allScreen/account.dart';
//import 'package:LPI_water_annimation/allScreen/tankManual.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class MQTTView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MQTTViewState();
  }
}

class _MQTTViewState extends State<MQTTView> {
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();
  MQTTAppState currentAppState;
  MQTTManager manager;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _hostTextController.dispose();
    _messageTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    currentAppState = appState;
    final Scaffold scaffold = Scaffold(
        appBar: new AppBar(
          title: Image.asset('images/logo.png', fit: BoxFit.fill),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(child: _buildColumn()),
        drawer: new Drawer(
            child: ListView(children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text('@' + 'Prasanjit'),
            accountEmail: new Text('ps.ee.1846@gmail.com'),
            currentAccountPicture: Image(
              image: AssetImage("images/logo.png"),
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
          ),
          new Divider(color: Colors.black, height: 5.0)
        ])));
    return scaffold;
  }

  Widget _buildColumn() {
    return Column(
      children: <Widget>[
        buildUI(),
        _buildScrollableTextWith(currentAppState.getReceivedText),
        _buildEditableColumn(),
        //_enableMQTT(currentAppState.getAppConnectionState),
      ],
    );
  }

  Widget buildUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "$mode",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: modeStateFunction),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 350.00,
                width: 350.0,
                child: LiquidCircularProgressIndicator(
                  value: waterLevel,
                  valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                  //backgroundColor: Colors.white,
                  borderColor: Colors.black54,
                  borderWidth: 15,
                  direction: Axis.vertical,
                  center: Text("$waterLevelPercentage"),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableColumn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          _buildPublishMessageRow(),
          const SizedBox(height: 10),
          //_buildConnecteButtonFrom(currentAppState.getAppConnectionState)
        ],
      ),
    );
  }

  //...........................................................

  Widget _buildPublishMessageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: _buildTextFieldWith(_messageTextController, 'Enter a message',
              currentAppState.getAppConnectionState),
        ),
        _buildSendButtonFrom(currentAppState.getAppConnectionState)
      ],
    );
  }

  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  Widget _buildTextFieldWith(TextEditingController controller, String hintText,
      MQTTAppConnectionState state) {
    bool shouldEnable = false;
    if (controller == _messageTextController &&
        state == MQTTAppConnectionState.connected) {
      shouldEnable = true;
    } else if ((controller == _hostTextController &&
            state == MQTTAppConnectionState.disconnected) ||
        (controller == _topicTextController &&
            state == MQTTAppConnectionState.disconnected)) {
      shouldEnable = true;
    }
    return TextField(
        enabled: shouldEnable,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: hintText,
        ));
  }
//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  Widget _buildSendButtonFrom(MQTTAppConnectionState state) {
    return RaisedButton(
      color: Colors.green,
      child: const Text('Send'),
      onPressed: state == MQTTAppConnectionState.connected
          ? () {
              _publishMessage(_messageTextController.text);
            }
          : null, //
    );
  }

  /*Widget _buildConnecteButtonFrom(MQTTAppConnectionState state) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
              color: Colors.lightBlueAccent,
              child: const Text('Connect'),
              onPressed: _configureAndConnect
              //
              ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
              color: Colors.redAccent,
              child: const Text('Disconnect'),
              onPressed: _disconnect
              //
              ),
        ),
      ],
    );
  }*/
  //............................................................

  Widget _buildScrollableTextWith(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 400,
        height: 50,
        //child: SingleChildScrollView(
        child: Text(text),

        //),
      ),
    );
  }

  //if(){
  double waterLevel = 0.0;
  double waterLevelPercentage = 0.0;

  int modeState = 0;
  String mode = 'Automatic';

  setWaterLevel() {
    setState(() {
      if (currentAppState.getReceivedText == null) {
        waterLevel = 0;
      } else {
        waterLevel = double.parse(currentAppState.getReceivedText);
      }
      waterLevelPercentage =
          double.parse((waterLevel * 100).toStringAsFixed(2));
    });
  }

  void modeStateFunction() {
    setState(() {
      if (modeState == 0) {
        mode = 'Manual';
        modeState = 1;
        _configureAndConnect();
      } else {
        mode = 'Automatic';
        modeState = 0;
      }
    });
  }

  void _configureAndConnect() {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(identifier: osPrefix, state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String text) {
    final String message = /*osPrefix + ' says: ' +*/ text;
    manager.publish(message);
    _messageTextController.clear();
  }
}
