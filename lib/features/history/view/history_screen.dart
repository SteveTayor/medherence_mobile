import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/model/models/history_model.dart';
import '../../../core/model/simulated_data/simulated_values.dart';
import '../../../core/utils/size_manager.dart';
import '../../home/view/medication_details.dart';
import '../../monitor/view_model/reminder_view_model.dart';
import '../widget/filter_widget.dart';
import '../widget/pie_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final ReminderState _historyData = ReminderState();
  final FocusManager focusManager = FocusManager.instance;
  int _tabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
        focusManager.primaryFocus?.unfocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Consumer<ReminderState>(builder: (context, _historyData, _) {
      return Scaffold(
        backgroundColor: AppColors.historyBackground,
        appBar: AppBar(
          backgroundColor: AppColors.historyBackground,
          title: Text(
            'History',
            style: TextStyle(
              fontSize: SizeMg.text(25),
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterView()));
                  },
                  icon: const Icon(Icons.filter_list_alt)),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeMg.radius(10),
                  ),
                  border: Border.all(
                    color: AppColors.navBarColor,
                    width: 2,
                  ),
                ),
                width: 300,
                child: TabBar(
                  dividerColor: AppColors.historyBackground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: (0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.navBarColor,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeMg.text(16),
                  ),
                  indicatorPadding: const EdgeInsets.all(0),
                  indicator: BoxDecoration(
                    color: AppColors.navBarColor,
                    borderRadius: BorderRadius.circular(
                      SizeMg.radius(10),
                    ),
                    border: Border.all(
                      width: SizeMg.width(2),
                      color: AppColors.historyBackground,
                    ),
                  ),
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      text: 'List',
                    ),
                    Tab(
                      text: 'Analytics',
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildMedicationHistory(_historyData, _tabIndex),
            ),
          ],
        ),
        // TabBarView(controller: _tabController, children: [
        //
        //   // Builder(builder: builder),
        // ]),
      );
    });
  }

  _buildMedicationHistory(ReminderState historyState, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return historyListBuilder(historyState);
      case 1:
        return analyticsBuilder(historyState);
      default:
        return Builder(builder: (ctx) {
          return _buildEmptyState();
        });
    }
  }

  Widget historyListBuilder(ReminderState reminderState) {
    return Builder(builder: (ctx) {
      List<HistoryModel> historyList = reminderState.historyList;
      if (historyList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeMg.width(30),
            vertical: SizeMg.height(10),
          ),
          child: Stack(
            children: [_buildEmptyState()],
          ),
        );
      }
      return SizedBox(
        width: SizeMg.screenWidth,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeMg.width(30),
            vertical: SizeMg.height(15),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: SizeMg.height(25)),
                child: Text(
                  'All',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: SizeMg.text(25),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeMg.width(20),
                    ),
                    Text(
                      'Regimen',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: SizeMg.text(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Dosage',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: SizeMg.text(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: SizeMg.text(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeMg.height(15)),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeMg.height(75),
                ),
                child: ListView.separated(
                  separatorBuilder: (ctx, index) {
                    return SizedBox(
                      height: SizeMg.height(5),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    final history = historyList[index];
                    String formattedDay = DateFormat('d').format(history.date);
                    String formattedMonth =
                        DateFormat('MMM').format(history.date);
                    Color containerColor;

                    switch (history.status) {
                      case AdherenceStatus.early:
                        containerColor = AppColors.success;
                        break;
                      case AdherenceStatus.late:
                        containerColor = AppColors.warning;
                        break;
                      case AdherenceStatus.missed:
                        containerColor = AppColors.error;
                        break;
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: SizeMg.height(5)),
                      child: Container(
                        height: SizeMg.height(55),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            SizeMg.radius(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Icon(
                                history.icon,
                                size: 24,
                                color: AppColors.pillIconColor,
                              ),
                            ),
                            Text(
                              history.regimenName,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeMg.text(16),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              history.dosage,
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: SizeMg.text(13),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: SizeMg.width(35),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    SizeMg.radius(10),
                                  ),
                                  bottomRight: Radius.circular(
                                    SizeMg.radius(10),
                                  ),
                                ),
                                color: containerColor,
                              ),
                              // color: AppColors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedDay,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: SizeMg.text(18),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    formattedMonth.toString(),
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: SizeMg.text(14),
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
      );
    });
  }

  Widget analyticsBuilder(ReminderState reminderState) {
    return Builder(builder: (ctx) {
      List<HistoryModel> historyList = reminderState.historyList;
      if (historyList.isEmpty) {
        return _buildEmptyState();
      }

      Map<AdherenceStatus, int> adherenceData =
          aggregateAdherenceData(historyList);

      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min here
            children: [
              Text(
                'All',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                // fit: FlexFit.loose,
                child: PieChartWidget(adherenceData: adherenceData),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: SizeMg.width(20),
                          height: SizeMg.height(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.success,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Early',
                          style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: SizeMg.text(16)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeMg.width(20),
                          height: SizeMg.height(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.warning,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Late',
                          style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: SizeMg.text(16)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeMg.width(20),
                          height: SizeMg.height(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.error,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Missed',
                          style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: SizeMg.text(16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.darkGrey.withOpacity(0.2),
              ),
              buildSummary(adherenceData),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSummary(Map<AdherenceStatus, int> adherenceData) {
    int totalUsed = adherenceData[AdherenceStatus.early]! +
        adherenceData[AdherenceStatus.late]!;
    int lateUsage = adherenceData[AdherenceStatus.late]!;
    int missedDays = adherenceData[AdherenceStatus.missed]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
            text: TextSpan(
                text: 'No. of days Med was used ',
                style: TextStyle(
                    fontSize: SizeMg.text(16),
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                children: [
              TextSpan(
                text: '(late usage)',
                style: TextStyle(
                  color: AppColors.darkGrey,
                ),
              )
            ])),
        SizedBox(height: 5),
        Text(
          '$totalUsed ($lateUsage)',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.darkGrey,
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: AppColors.darkGrey.withOpacity(0.2),
        ),
        Text(
          'No. of days Med was missed',
          style: TextStyle(
            fontSize: SizeMg.text(16),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$missedDays',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.darkGrey,
          ),
        ),
        Divider(
          color: AppColors.darkGrey.withOpacity(0.2),
        ),
      ],
    );
  }

  Map<AdherenceStatus, int> aggregateAdherenceData(
      List<HistoryModel> historyList) {
    int earlyCount = 0;
    int lateCount = 0;
    int missedCount = 0;

    for (var history in historyList) {
      switch (history.status) {
        case AdherenceStatus.early:
          earlyCount++;
          break;
        case AdherenceStatus.late:
          lateCount++;
          break;
        case AdherenceStatus.missed:
          missedCount++;
          break;
      }
    }

    return {
      AdherenceStatus.early: earlyCount,
      AdherenceStatus.late: lateCount,
      AdherenceStatus.missed: missedCount,
    };
  }

  /// Returns an empty state widget when no data is available.
  Widget _buildEmptyState() {
    return Center(
      child: SizedBox(
        height: SizeMg.height(150),
        width: SizeMg.width(180),
        child: Column(
          children: [
            SizedBox(
              height: SizeMg.height(20),
            ),
            const Icon(
              Icons.folder_off_outlined,
              color: AppColors.noWidgetText,
            ),
            SizedBox(
              height: SizeMg.height(10),
            ),
            Text(
              'You have new adherence history',
              style: TextStyle(
                fontSize: SizeMg.text(20),
                fontStyle: FontStyle.italic,
                color: AppColors.noWidgetText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
