import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/src/assets_manager.dart';
import 'package:sehr/presentation/src/colors_manager.dart';

import '../profile/forgotpassword.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.pattern2,
            color: ColorManager.primary.withOpacity(0.1),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const TopBackButtonWidget(),
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: const [
                      Text(
                        "General",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9CA4AB)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.notifications),
                  trailing: Switch(
                    onChanged: (s) {},
                    value: true,
                    activeColor: const Color(0xffEFEFEF),
                    activeTrackColor: const Color(0xff4698B4),
                  ),
                  title: const Text(
                    "Notifications",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: const [
                      Text(
                        "Security",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9CA4AB)),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => ForgotPassView(
                          enterphonedetails: true,
                          phone: "",
                          token: "",
                        ));
                  },
                  dense: true,
                  leading: const Icon(Icons.password),
                  title: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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

listtilecustom(String title, IconData iconData) {
  return ListTile(
    dense: true,
    leading: Icon(iconData),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}

listtilecustoms(String title, IconData iconData) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      dense: true,
      leading: Icon(iconData),
      trailing: const Icon(Icons.message),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
