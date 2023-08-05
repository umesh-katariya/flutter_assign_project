import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assign_project/utils/app_assets.dart';
import 'package:flutter_assign_project/utils/app_styles.dart';
import 'package:flutter_assign_project/utils/app_utils.dart';
import 'package:intl/intl.dart';

import '../../ApiService/api_service.dart';
import '../../utils/loading_dialog.dart';
import '../GamificationScreen/gamification_screen.dart';

class ProfileSummaryState extends ChangeNotifier{

  String name;
  String gender;
  DateTime dob;
  String profession;
  String technology;
  var screenJson;

  ProfileSummaryState(
      {required this.name, required this.gender, required this.dob, required this.profession, required this.technology, required this.screenJson});
  
  
  reFilled(BuildContext context){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const GamificationScreen(),), (route) => false);
  }

  confirm(BuildContext context)async{

    Map<String, dynamic> apiRequest = { "name": name ,"gender":  gender,  "dob": DateFormat("dd/MM/yyyy").format(dob), "profession":profession,"skills":technology};

    showLoader(context);

    await ApiService.postApiCallArgs(
        url: URLS.postUserInformation,
        apiRequest: apiRequest)
        .then((value) {
      hideLoader(context);
      if (value == null) {
        successMessageDialog(context,"Something went wrong");
      } else {
        if (value["success"]) {
          successMessageDialog(context,"Success 🎉");
        } else {
          successMessageDialog(context,value["message"]);
        }
      }
    });
  }

  successMessageDialog(BuildContext context,String content) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                              child: Image.asset(AppAssets.closeIcon,height: 24,width: 24,)))
                    ],
                  ),
                  30.height(),
                  Text(content,style: AppStyles.blackBold30,),
                  50.height(),
                ],
              ),
            ));
      },
    );
  }


}