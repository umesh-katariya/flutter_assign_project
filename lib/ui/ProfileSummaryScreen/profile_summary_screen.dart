import 'package:flutter/material.dart';
import 'package:flutter_assign_project/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/center_button.dart';
import '../GamificationScreen/gamification_state.dart';
import 'profile_summary_state.dart';

class ProfileSummaryScreen extends StatelessWidget {
  String name;
  String gender;
  DateTime dob;
  String profession;
  String technology;
  var screenJson;

  ProfileSummaryScreen(
      {Key? key,
      required this.name,
      required this.gender,
      required this.dob,
      required this.profession,
      required this.technology,
      required this.screenJson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileSummaryState>(
      create: (context) => ProfileSummaryState(
        name: name,
        gender: gender,
        dob: dob,
        profession: profession,
        technology: technology,
        screenJson: screenJson,
      ),
      child: ProfileSummaryBodyView(),
    );
  }
}

class ProfileSummaryBodyView extends StatelessWidget {
  ProfileSummaryBodyView({Key? key}) : super(key: key);

  ProfileSummaryState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<ProfileSummaryState>(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyView(context),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Profile Summary', style: AppStyles.whiteRegular16),
      centerTitle: true,
      elevation: 3,
    );
  }

  Widget _buildBodyView(BuildContext context) {
    return Column(
      children: [_buildHeaderView(), 30.height(), _buildDetailsView(context)],
    );
  }

  Widget _buildHeaderView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi, ",
                style: AppStyles.whiteBold18,
              ),
              Text(
                state!.name,
                style: AppStyles.whiteBold18.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          20.height(),
          Text(
            "You did it 🎉",
            style: AppStyles.whiteBold28,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsView(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please review your answers below and do change if any or confirm and continue.",
              style: AppStyles.blackRegular16,
            ),
            30.height(),
            Text(
              "My personal details 🙂",
              style: AppStyles.whiteBold18.copyWith(color: AppColors.primaryColor),
            ),
            10.height(),
            Text(
              "My name is ${state!.name.trim()} I am a ${state!.gender??""} born on ${DateFormat("dd/MM/yyyy").format(state!.dob!)}",
              style: AppStyles.blackRegular18,
            ),
            30.height(),
            Text(
              "How I keep busy 💻",
              style: AppStyles.whiteBold18.copyWith(color: AppColors.primaryColor),
            ),
            10.height(),
            Text(
              "I am ${state!.profession} and I ${state!.technology}.",
              style: AppStyles.blackRegular18,
            ),
            const Spacer(),
            IntrinsicHeight(
              child: Row(
                children: [
                  InkWell(
                    onTap: () => state!.reFilled(context),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.black12,
                                spreadRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.refresh,color: Color(0xFF292D32),),
                    ),
                  ),
                  10.width(),
                  Expanded(
                    child: CenterButton(
                        radius: 8,
                        fontsize: 16,
                        ontap: ()=> state!.confirm(context),
                        text: "Confirm",
                        fontWeight: FontWeight.w500,
                        txtColor: AppColors.blackColor),
                  ),
                ],
              ),
            ),
            20.height(),
          ],
        ),
      ),
    );
  }
}
