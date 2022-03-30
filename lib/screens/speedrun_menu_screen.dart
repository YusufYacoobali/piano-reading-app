import 'package:flutter/material.dart';
import '../components/app_bar_with_settings_icon.dart';
import '../components/pop_ups/speedrun_menu_instructions.dart';
import '../components/pop_up_components/pop_up_controller.dart';
import '../screens/menu_screen.dart';
import '../screens/speedrun_screen.dart';
import 'speedrun_screen.dart';
import 'package:sight_reading_app/helper.dart';

///A list containing the various speedrun mode options.
List<int> modes = [10, 20, 30, 40, 50, 60];

///A list containing the keys for each of the buttons generated by build()
List<Key> modeButtonKeys = <Key>[];

/// A list containing the user records for each of the modes.
List<String> modeRecords = <String>[];

///A screen that displays a scrollable list of available speedrun modes with buttons to access each mode.
///
/// An app bar is present at the top of the screen, which contains the screen's title text, a back arrow and a clickable settings icon that takes you to the settings screen.
class _SpeedrunMenuScreenState extends State<SpeedrunMenuScreen> {
  final ScrollController _firstController = ScrollController();

  @override
  void initState() {
    _loadRecords();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Loads the records for the speedrun mode.
  void _loadRecords() async {
    //Sets default values to use while the real records load.
    modeRecords = resetRecordListForMode('speedrun');
    // Once the real records are loaded, the screen is refreshed with the new values.
    getRecordsForMode('speedrun').then((value) {
        setState(() {
          modeRecords = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    modeButtonKeys = <Key>[]; //Resets key list.
    //Generates the keys for the speedrun mode buttons based on mode name.
    for (int mode in modes) {
      modeButtonKeys.add(Key('modeSelected:$mode'));
    }
    return _getScreenWidget();
  }

  /// The widget to be displayed to the user.
  Widget _getScreenWidget() {
    /// A pop-up screen containing the speedrun instructions.
    PopUpController menu = PopUpController(
        context: context,
        menuBuilder: SpeedrunMenuInstructions(context: context));
    return Scaffold(
        appBar: AppBarWithSettingsIcon(const Text('Choose a duration:'), menu),
        body: SafeArea(
          /// Uses an itemBuilder to generate a button for each mode, using the names, records and keys generated earlier.
          child: Scrollbar(
            controller: _firstController,
            isAlwaysShown: true,
            child: ListView.separated(
              controller: _firstController,
              padding: const EdgeInsets.all(8),
              itemCount: modes.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 100, //Fixes the button height
                  child: MenuButton(
                    buttonChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(modes[index].toString() + ' seconds',
                            textAlign: TextAlign.left),
                        SizedBox(
                            width: MediaQuery.of(context).size.width /
                                4), //Adds space between Text
                        Text('Record: ${modeRecords[index]}',
                            textAlign: TextAlign.right),
                      ],
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpeedrunScreen(
                            timerDuration: modes[index],
                          ),
                        ),
                      );
                    },
                    key: modeButtonKeys[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            ),
          ),
        ));
  }
}

///The state for the speedrun menu screen.
class SpeedrunMenuScreen extends StatefulWidget {
  ///The id used to identify the screen.
  static const String id = 'speedrun_menu_screen';

  const SpeedrunMenuScreen({Key? key}) : super(key: key);

  @override
  _SpeedrunMenuScreenState createState() => _SpeedrunMenuScreenState();
}
