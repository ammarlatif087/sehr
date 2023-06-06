import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/src/colors_manager.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';

class PermissionHandler extends StatelessWidget {
  const PermissionHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset("assets/images/process.png"),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "We need to access to your location in order to determine which shops to surface, Please Enable The Location of your device",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Get.offAll(() => DrawerView(
                    pageindex: 0,
                  ));
            },
            child: Container(
              color: ColorManager.primary,
              height: 40,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Enable",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
