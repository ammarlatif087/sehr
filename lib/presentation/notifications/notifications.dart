import 'package:sehr/app/index.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sehr/presentation/views/business_views/requested_order/requested_orders_view.dart';

class NotificationController extends GetxController {
  AudioPlayer player = AudioPlayer();

  var notificationlist = <dynamic>[].obs;
  var postloading = true.obs;
  bool dontshowfirsttime = false;
  callNotifications(List datalist, BuildContext context) async {
    try {
      postloading.value = true;
      var streamLength = await listData(datalist);
      // print(dontshowfirsttime);
      if (streamLength == notificationlist.length ||
          streamLength < notificationlist.length) {
      } else {
        if (dontshowfirsttime == true) {
          await player.setAsset('sounds/alert.mp3');
          //play audio
          player.play();
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("New Order"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.to(() => const RequestedOrdersView());
                        },
                        child: const Text("Ok"))
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: const [
                            Expanded(
                                child: Text(
                                    "You received a new order, check out")),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        }
      }
      dontshowfirsttime = true;
      notificationlist.assignAll(datalist);
    } finally {
      postloading.value = false;
    }

    update();
  }

  listData(List datalist) {
    return datalist.length;
  }

  shownotification() {}
}
