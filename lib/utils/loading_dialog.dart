import 'package:flutter/material.dart';

import 'app_colors.dart';

showLoader(context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetPadding: EdgeInsets.all(0.4),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                //color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(7),
              ),
              width: 40,
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        );
      });
}

hideLoader(context){
  Navigator.pop(context);
}


