import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/top_back_button_widget.dart';
import 'package:sehr/presentation/src/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            // height: SizeConfig.screenHeight * 0.48,
            // width: SizeConfig.screenWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TopBackButtonWidget(),
              ],
            ),
          ),
          // Image.asset(
          //   AppImages.pattern2,
          //   color: ColorManager.primary.withOpacity(0.1),
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Need Help? Call us now",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: double.infinity,
                    child: TaxiButton(
                        icon: Icons.call,
                        title: '051 5421151',
                        color: ColorManager.primary,
                        onPressed: () {
                          UrlLauncher.launch("tel://0515421151");
                        }),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Visit Our Website",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: double.infinity,
                    child: TaxiButton(
                      icon: Icons.web,
                      title: 'www.sehr.pk',
                      color: const Color.fromARGB(255, 1, 99, 74),
                      onPressed: () async {
                        launchUrl(Uri.parse("https://sehr.pk/"));
                      },
                    ),
                  ),
                ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.grey[300],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: const [
                //       Text(
                //         "or Join Our Facebook Page",
                //         style: TextStyle(
                //             fontSize: 16, fontWeight: FontWeight.bold),
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(12),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: TaxiButton(
                //         icon: Icons.facebook,
                //         title: 'Facebook',
                //         color: const Color.fromARGB(255, 30, 2, 49),
                //         onPressed: () {

                //           // launchUrl(
                //           //     Uri.parse("https://www.facebook.com/sehr.pk/"));
                //         }),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Not available in Source Downloaded.

class TaxiButton extends StatelessWidget {
  final String title;
  final Color color;
  final IconData? icon;

  final Function() onPressed;

  const TaxiButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
      child: SizedBox(
        height: 50,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
            ),
          ],
        )),
      ),
    );
  }
}
