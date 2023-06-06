import 'package:flutter/material.dart';
import 'package:sehr/presentation/src/colors_manager.dart';

showdialogOrders(BuildContext context, String title, Function() functionsk) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          actions: [
            TextButton(
                onPressed: functionsk,
                child: Text(
                  "Confirm",
                  style: TextStyle(color: ColorManager.primary),
                ))
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Are You Sure To $title this Request?")],
          ),
        );
      });
}

pleasewaitDIALOG(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text("Please Wait"))
                ],
              )
            ],
          ),
        );
      });
}

errordialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: ColorManager.primary),
                ))
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text("ERROR ! Please try again"))
                ],
              )
            ],
          ),
        );
      });
}
