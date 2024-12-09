import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medherence/core/utils/size_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/model/models/history_model.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../auth/views/change_password.dart';
import '../../dashboard_feature/view/dashboard_view.dart';
import '../../history/view/history_screen.dart';
import '../../medhecoin/view/medhecoin.dart';
import '../../monitor/view_model/reminder_view_model.dart';
import '../../notification/view/notification_view.dart';
import '../../notification/widget/notification_widget.dart';
import '../../profile/view_model/profile_view_model.dart';
import '../widget/medecoin_widget.dart';
import '../widget/progressStreak.dart';
import 'medication_details.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showHistory = false;
  List<dynamic> history = []; // Initialize history list

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // Check if password change is required on app start
      checkPasswordChangePrompt();
    });
  }

  // Function to show password change prompt if necessary
  void checkPasswordChangePrompt() async {
    bool passwordChanged = await isPasswordChanged();
    if (!passwordChanged) {
      buildCompleteProfile();
    }
  }

  // Function to check if password has been successfully changed
  Future<bool> isPasswordChanged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('passwordChanged') ?? false;
  }

  // Function to display password change prompt
  buildCompleteProfile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Change Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'There is a need for you to change your password from the default password you were given to a personal one',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: PrimaryButton(
              buttonConfig: ButtonConfig(
                text: 'Change Password',
                action: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ));
                },
                disabled: false,
              ),
              width: double.infinity,
            ),
          ),
        ],
      ),
    );

    // Delay dialog auto-dismissal
    await Future.delayed(const Duration(seconds: 5));
  }

  // Toggle variable for amount changed display
  bool _amountChanged = false;

  // Function to toggle the amount changed display
  void toggleAmountChanged() {
    setState(() {
      _amountChanged = !_amountChanged;
    });
  }

  // Update progress and title based on progress count
  int progress = 1;
  String title = 'ADB'; // Initial title

  void updateProgress() {
    setState(() {
      progress++;
      if (progress == 1) {
        title = 'ADB';
      } else if (progress == 2) {
        title = 'Serg';
      } else if (progress == 3) {
        title = 'Lt.';
      } else {
        title = 'Master ${progress - 2}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context); // Initialize size manager

    return Consumer<ReminderState>(builder: (context, reminderState, _) {
      List<HistoryModel> regimenList = reminderState.regimenList;
      int remainingMedications =
          regimenList.length - reminderState.getCheckedCount();
      int medcoinBalance = reminderState.medcoin;
      double medcoinInNaira = reminderState.medcoinInNaira;
      String coinTitle = _amountChanged ? 'Amount in Naira' : 'Amount in MDHC';
      String amount = _amountChanged
          ? medcoinInNaira.toStringAsFixed(2)
          : medcoinBalance.toString();

      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Welcome, ${context.watch<ProfileViewModel>().nickName.isNotEmpty ? context.watch<ProfileViewModel>().nickName : 'ADB'}',
              style: TextStyle(
                fontSize: SizeMg.text(22),
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins-bold.ttf",
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeMg.width(8), right: SizeMg.width(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NotificationWidget(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: SizeMg.height(5)),
                ProgressStreak(
                    progress: progress), // Display progress streak bar
                SizedBox(height: SizeMg.height(20)),
                MedhecoinWidget(
                  onTap: toggleAmountChanged,
                  iconData: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MedhecoinScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.open_in_new,
                      color: AppColors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedhecoinScreen()),
                    );
                  },
                  amountChanged: _amountChanged,
                  coinTitle: coinTitle,
                  amount: amount,
                ),
                SizedBox(height: SizeMg.height(15)),
                Text(
                  'Today\'s Medications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins-Bold.ttf",
                    fontSize: SizeMg.text(20),
                  ),
                ),
                SizedBox(height: 5),
                // Display message when regimenList is empty
                if (regimenList.isEmpty)
                  Center(
                    child: SizedBox(
                      height: 250,
                      width: 300,
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Icon(
                            Icons.check_circle_outline_sharp,
                            color: AppColors.historyBackground,
                            size: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Yayy, You have taken all medications for today',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: AppColors.noWidgetText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                // Display regimen list
                SizedBox(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: remainingMedications,
                    separatorBuilder: (ctx, index) =>
                        SizedBox(height: SizeMg.height(3)),
                    itemBuilder: (context, index) {
                      HistoryModel regimenItem = regimenList[index];
                      return NextRegimen(itemModel: regimenItem);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryScreen()),
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10, bottom: SizeMg.height(5)),
                      child: Text(
                        'View Adherence History',
                        style: TextStyle(
                          color: AppColors.navBarColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins-Bold.ttf",
                          fontSize: SizeMg.text(18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Function to display history in a bottom sheet
  buildHistorySheet(List<HistoryModel> historyList, BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 0.5,
      isScrollControlled: true,
      backgroundColor: AppColors.historyBackground,
      builder: (context) {
        return ColoredBox(
          color: AppColors.historyBackground,
          child: DraggableScrollableSheet(
            initialChildSize: 0.4,
            maxChildSize: 0.8,
            expand: false,
            builder: (context, scrollController) {
              if (historyList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Text(
                          'History',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 150,
                          width: 180,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.folder_off_outlined,
                                color: AppColors.noWidgetText,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'You have no adherence history',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.noWidgetText,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        'History',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 20),
                              Text(
                                'Regimen',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Dosage',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: historyList.length,
                              separatorBuilder: (ctx, index) =>
                                  SizedBox(height: 13),
                              itemBuilder: (context, index) {
                                final item = historyList[index];
                                final formattedMonth =
                                    DateFormat('MMM').format(item.date);
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MedicationDetailsScreen(
                                          title: item.regimenName,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 55,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Icon(
                                            item.icon,
                                            size: 24,
                                            color: AppColors.pillIconColor,
                                          ),
                                        ),
                                        Text(
                                          item.regimenName,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          item.dosage,
                                          style: TextStyle(
                                            color: AppColors.darkGrey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: AppColors.mainPrimaryButton,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                item.date.day.toString(),
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                formattedMonth.toString(),
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class NextRegimen extends StatelessWidget {
  const NextRegimen({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final HistoryModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: SizeMg.screenWidth,
        decoration: BoxDecoration(
          color: AppColors.historyBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Image.asset(
                  'assets/images/pill.png',
                  height: 28,
                  width: 28,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemModel.regimenName,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    itemModel.dosage,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: AppColors.navBarColor,
                        size: 14,
                      ),
                      SizedBox(width: 10),
                      Text(
                        DateFormat('hh:mm a').format(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          itemModel.time.hour,
                          itemModel.time.minute,
                        )),
                        style: TextStyle(
                          color: AppColors.navBarColor,
                          fontSize: SizeMg.text(12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  debugPrint('Regimen taken');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetDashboardView(dashboardIndex: 1),
                    ),
                  );
                },
                child: Text(
                  'Take',
                  style: TextStyle(
                    color: AppColors.navBarColor,
                    fontSize: SizeMg.text(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
