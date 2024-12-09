import 'package:flutter/material.dart';
import 'package:medherence/features/auth/views/login_view.dart';
import 'package:stacked/stacked.dart';

import '../../home/view/home_view.dart';
import '../../monitor/view/reminder_screen.dart';
import '../view_model/dashboard_view_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'menu.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (_, model, __) => Scaffold(
        body: GetDashboardView(
          dashboardIndex: model.currentIndex,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          model: model,
        ),
      ),
    );
  }
}

class GetDashboardView extends StatelessWidget {
  final int dashboardIndex;

  const GetDashboardView({
    Key? key,
    required this.dashboardIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dashboardIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const MedicationListScreen();
      case 2:
        return const MenuScreen();
      default:
        return const LoginView();
    }
  }
}
