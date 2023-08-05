import 'package:flutter/material.dart';
import 'package:flutter_assign_project/utils/app_colors.dart';
import 'package:flutter_assign_project/utils/app_utils.dart';
import 'package:flutter_assign_project/utils/center_button.dart';
import 'package:flutter_assign_project/utils/common_textfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/app_styles.dart';
import 'gamification_state.dart';

class GamificationScreen extends StatelessWidget {
  const GamificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GamificationState>(
      create: (context) => GamificationState(),
      child: GamificationBodyView(),
    );
  }
}

class GamificationBodyView extends StatelessWidget {
  GamificationBodyView({Key? key}) : super(key: key);

  GamificationState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<GamificationState>(context);
    return WillPopScope(
      onWillPop: () async {
        state!.onBackPress();
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBodyView(context),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Gamification', style: AppStyles.whiteRegular16),
      centerTitle: true,
      elevation: 3,
    );
  }

  Widget _buildBodyView(BuildContext context) {
    return Column(
      children: [
        _buildProgressView(),
        30.height(),
        _buildDynamicWidgetView(context)
      ],
    );
  }

  Widget _buildProgressView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${state!.currentScreen["heading"]}",
            style: AppStyles.whiteBold18,
          ),
          30.height(),
          LinearProgressIndicator(
            value: state!.progress,
            color: AppColors.primaryColor,
            backgroundColor: AppColors.whiteColor,
          )
        ],
      ),
    );
  }

  Widget _buildDynamicWidgetView(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
        child: _buildManageView(context),
      ),
    );
  }

  Widget _buildManageView(BuildContext context) {
    //print("object ${state!.currentScreen}");
    if (state!.currentScreen["screen_name"] == "name") {
      return _buildNameView(context);
    } else if (state!.currentScreen["screen_name"] == "gender") {
      return _buildGenderView(context);
    } else if (state!.currentScreen["screen_name"] == "dob") {
      return _buildDOBView(context);
    } else if (state!.currentScreen["screen_name"] == "profession") {
      return _buildProfessionView(context);
    } else if (state!.currentScreen["screen_name"] == "technology") {
      return _buildTechnologyView(context);
    }

    return Container();
  }

  Widget _buildNameView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${state!.currentScreen["question"]}",
          style: AppStyles.whiteBold28.copyWith(color: AppColors.primaryColor),
        ),
        24.height(),
        CommonTextfieldRectangle(
            controller: state!.nameController,
            onChange: (value) {
              state!.notifyListeners();
            },
            hintText: "${state!.currentScreen["hint_text"]}"),
        const Spacer(),
        CenterButton(
            radius: 8,
            fontsize: 16,
            ontap: ()=> state!.nextScreen(context),
            text: "Next",
            fontWeight: FontWeight.w500,
            txtColor: AppColors.blackColor,
            isDisable: (state!.nameController.text.isNotEmpty || state!.nameController.text.length>60)==false),
        24.height(),
      ],
    );
  }

  Widget _buildGenderView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My name is ${state!.nameController.text}",
          style: AppStyles.blackRegular16,
        ),
        24.height(),
        Text(
          "${state!.currentScreen["question"]}",
          style: AppStyles.whiteBold28.copyWith(color: AppColors.primaryColor),
        ),
        24.height(),
        Row(
          children: [
            ...List.generate(
                state!.currentScreen["options"].length, (index) {
                  var option = state!.currentScreen["options"][index];
                  bool isSelected  = option["value"] == state!.isMale;
                  return Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: InkWell(
                      onTap: () => state!.selectGender(option["value"]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Radio(
                              groupValue: state!.isMale,
                              onChanged: state!.selectGender,
                              value: option["value"],
                              activeColor: AppColors.primaryColor,
                            ),
                          ),
                          10.width(),
                          Text(option["value"],style: AppStyles.blackRegular16.copyWith(color: isSelected?AppColors.primaryColor:AppColors.blackColor),)
                        ],
                      ),
                    ),
                  );
            }),
          ],
        ),
        const Spacer(),
        CenterButton(
            radius: 8,
            fontsize: 16,
            ontap: ()=> state!.nextScreen(context),
            text: "Next",
            fontWeight: FontWeight.w500,
            txtColor: AppColors.blackColor,
            isDisable: state!.isMale == null),
        24.height(),
      ],
    );
  }

  Widget _buildDOBView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My name is ${state!.nameController.text.trim()} I am a ${state!.isMale??""}",
          style: AppStyles.blackRegular16,
        ),
        24.height(),
        Text(
          "${state!.currentScreen["question"]}",
          style: AppStyles.whiteBold28.copyWith(color: AppColors.primaryColor),
        ),
        24.height(),
        InkWell(
          onTap: () => state!.selectDOB(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.hintColor),
                color: AppColors.textFillColorColor),
            alignment: Alignment.centerLeft,
            child: state!.selectedDOB != null
                ? Text(
                    DateFormat("dd/MM/yyyy").format(state!.selectedDOB!),
                    style: AppStyles.hintTextStyle,
                  )
                : Text(
                    "${state!.currentScreen["hint_text"]}",
                    style: AppStyles.hintTextStyle,
                  ),
          ),
        ),
        const Spacer(),
        CenterButton(
            radius: 8,
            fontsize: 16,
            ontap: ()=> state!.nextScreen(context),
            text: "Next",
            fontWeight: FontWeight.w500,
            txtColor: AppColors.blackColor,
            isDisable: state!.selectedDOB == null),
        24.height(),
      ],
    );
  }

  Widget _buildProfessionView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My name is ${state!.nameController.text.trim()} I am a ${state!.isMale??""} born on ${DateFormat("dd/MM/yyyy").format(state!.selectedDOB!)}",
          style: AppStyles.blackRegular16,
        ),
        24.height(),
        Text(
          "${state!.currentScreen["question"]}",
          style: AppStyles.whiteBold28.copyWith(color: AppColors.primaryColor),
        ),
        24.height(),
        ...List.generate(state!.currentScreen["options"].length, (index) {
          var option = state!.currentScreen["options"][index];
          bool isSelected  = option["value"] == state!.selectedProfession;
          return InkWell(
            onTap: () => state!.selectProfession(option["value"],option),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Radio(
                    groupValue: state!.selectedProfession,
                    onChanged: (value) => state!.selectProfession(option["value"],option),
                    value: option["value"],
                    activeColor: AppColors.primaryColor,
                  ),
                ),
                10.width(),
                Text(option["text"],style: AppStyles.blackRegular16.copyWith(color: isSelected?AppColors.primaryColor:AppColors.blackColor),)
              ],
            ),
          );
        }),
        const Spacer(),
        CenterButton(
            radius: 8,
            fontsize: 16,
            ontap: ()=> state!.nextScreen(context),
            text: "Next",
            fontWeight: FontWeight.w500,
            txtColor: AppColors.blackColor,
            isDisable: state!.selectedProfession == null),
        24.height(),
      ],
    );
  }

  Widget _buildTechnologyView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I am ${state!.selectedProfession}",
          style: AppStyles.blackRegular16,
        ),
        24.height(),
        Text(
          "${state!.currentScreen["question"]}",
          style: AppStyles.whiteBold28.copyWith(color: AppColors.primaryColor),
        ),
        24.height(),
        if(state!.currentScreen["fields"].contains("textfield"))
          CommonTextfieldRectangle(
              controller: TextEditingController(text: state!.selectedTechnology),
              onChange: (value) {
                state!.selectedTechnology=value;
                state!.notifyListeners();
              },
              hintText: "${state!.currentScreen["hint_text"]}"),
        if(state!.currentScreen["fields"].contains("radio"))
        ...List.generate(state!.currentScreen["options"].length, (index) {
          var option = state!.currentScreen["options"][index];
          bool isSelected  = option["value"] == state!.selectedTechnology;
          return InkWell(
            onTap: () => state!.selectTechnology(option["value"]),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Radio(
                    groupValue: state!.selectedTechnology,
                    onChanged: (value) => state!.selectTechnology(option["value"]),
                    value: option["value"],
                    activeColor: AppColors.primaryColor,
                  ),
                ),
                10.width(),
                Text(option["text"],style: AppStyles.blackRegular16.copyWith(color: isSelected?AppColors.primaryColor:AppColors.blackColor),)
              ],
            ),
          );
        }),
        const Spacer(),
        CenterButton(
            radius: 8,
            fontsize: 16,
            ontap: ()=> state!.nextScreen(context),
            text: "Next",
            fontWeight: FontWeight.w500,
            txtColor: AppColors.blackColor,
            isDisable: state!.selectedTechnology == null || state!.selectedTechnology!.isEmpty),
        24.height(),
      ],
    );
  }
}
