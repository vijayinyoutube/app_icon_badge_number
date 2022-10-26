import '../../Components/app_bar.dart';
import '../../Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: title),
      body: Center(
        child: ElevatedButton(
          style: getBtnStyle(context),
          child: const Text('Set batch no'),
          onPressed: () => setBatchNum(5, context),
        ),
      ),
    );
  }

  setBatchNum(int count, BuildContext context) async {
    try {
      await FlutterDynamicIcon.setApplicationIconBadgeNumber(count);
    } on PlatformException {
      print('Exception: Platform not supported');
    } catch (e) {
      print(e);
    }
    // To get currently batch number that was set.
    int batchNumber = await FlutterDynamicIcon.getApplicationIconBadgeNumber();
    // Quick alert box for acknowledgement
    QuickAlert.show(
      context: context,
      title: 'Batch Number set as $batchNumber',
      text: 'Minimize the app to check it out!',
      type: QuickAlertType.success,
      confirmBtnColor: primaryColor,
    );
  }
}
