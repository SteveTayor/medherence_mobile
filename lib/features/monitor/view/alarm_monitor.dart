import 'package:flutter/material.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/core/utils/image_utils.dart';
import 'package:medherence/features/dashboard_feature/view/dashboard_view.dart';

import '../../../core/utils/size_manager.dart';

class AlarmMonitor extends StatefulWidget {
  static const routeName = '/alarm_monitor';
  final String regimen;
  final String subtitle;

  const AlarmMonitor(
      {required this.subtitle, required this.regimen, super.key});

  @override
  State<AlarmMonitor> createState() => _AlarmMonitorState();
}

class _AlarmMonitorState extends State<AlarmMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alarm',
          style: TextStyle(
            fontSize: SizeMg.text(25),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.white,
        width: SizeMg.screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    child: Center(
                  child: Image.asset(
                    ImageUtils.alarmPillIcon,
                    height: 100,
                    width: 100,
                  ),
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.regimen,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: SizeMg.text(22),
                ),
              ),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: SizeMg.text(16),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                buttonConfig: ButtonConfig(
                  text: 'Take Regimen',
                  action: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardView()),
                    );
                  },
                ),
                width: SizeMg.screenWidth,
              ),
              SizedBox(height: SizeMg.height(15)),
              OutlinePrimaryButton(
                buttonConfig: ButtonConfig(
                  text: 'Snooze',
                  action: () {},
                ),
              ),
              SizedBox(height: SizeMg.height(60)),
            ],
          ),
        ),
      ),
    );
  }
}
