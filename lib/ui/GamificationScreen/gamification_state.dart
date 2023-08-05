import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/app_utils.dart';
import '../ProfileSummaryScreen/profile_summary_screen.dart';

class GamificationState with ChangeNotifier {

  int currentScreenIndex=0;
  var currentScreen;

  int totalScreens = 0;
  double progress = 0.0;

  var screensJson;

  TextEditingController nameController = TextEditingController();

  String? isMale;

  DateTime? selectedDOB;

  String? selectedProfession;
  var selectedProfessionType;

  String? selectedTechnology;

  GamificationState(){

    screensJson = screensJsonData;

    totalScreens = screensJson["screens"].length + 1;

    currentScreen=screensJson["screens"][currentScreenIndex];

    notifyListeners();

  }

  selectGender(value){
    isMale = value;
    notifyListeners();
  }

  selectProfession(value,type){
    selectedProfession = value;
    selectedProfessionType = type;
    notifyListeners();
  }

  selectTechnology(value){
    selectedTechnology = value;
    notifyListeners();
  }

  nextScreen(BuildContext context){
    print("call nextScreen");

    if(currentScreen["screen_name"] == "name"){
      screensJson["screens"][currentScreenIndex]["ans"] = nameController.text;
    }else if(currentScreen["screen_name"] == "gender"){
      screensJson["screens"][currentScreenIndex]["ans"] = isMale;
    }else if(currentScreen["screen_name"] == "dob"){
      screensJson["screens"][currentScreenIndex]["ans"] = DateFormat("dd/MM/yyyy").format(selectedDOB!);
    }else if(currentScreen["screen_name"] == "profession"){
      screensJson["screens"][currentScreenIndex]["ans"] = selectedProfession;
    }else if(currentScreen["screen_name"] == "technology"){
      screensJson["screens"][currentScreenIndex-1]["child_screen"][selectedProfessionType["key"]][0]["ans"] = selectedTechnology;
    }

    if(currentScreenIndex == totalScreens-1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSummaryScreen(
          name : nameController.text,
          gender : isMale!,
          dob : selectedDOB!,
          profession : selectedProfession!,
          technology : selectedTechnology!,
          screenJson : screensJson
      ),));
      return;
    }

    if(currentScreen["screen_name"] == "profession") {
      print("object--- ${selectedProfessionType["key"]}");
      print("object--- ${screensJson["screens"][currentScreenIndex]["child_screen"][selectedProfessionType["key"]]}");
      selectedTechnology="";
      currentScreen = screensJson["screens"][currentScreenIndex]["child_screen"][selectedProfessionType["key"]][0];
      currentScreenIndex++;
      notifyListeners();
    }else {
      currentScreenIndex++;
      currentScreen = screensJson["screens"][currentScreenIndex];
      notifyListeners();
    }


    calculateProgress();
  }

  onBackPress(){
    if(currentScreenIndex==0){
    }else {
      //print("object ${currentScreen["screen_name"]}");
      currentScreenIndex--;
      currentScreen = screensJson["screens"][currentScreenIndex];
      notifyListeners();
    }
    calculateProgress();
  }

  calculateProgress(){
    progress = (currentScreenIndex/totalScreens).toDouble();
    notifyListeners();
  }

  selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDOB??DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDOB) {
      selectedDOB = picked;
      notifyListeners();
    }
  }

}
