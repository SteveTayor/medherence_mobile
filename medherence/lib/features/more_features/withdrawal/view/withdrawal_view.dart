import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medherence/features/medhecoin/view_model/medhecoin_wallet_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/shared_widget/buttons.dart';
import '../../../../core/utils/color_utils.dart';
import '../../../../core/utils/size_manager.dart';
import '../../../../core/utils/utils.dart';
import '../../../monitor/view_model/reminder_view_model.dart';
import '../view_model/withdrawal_view_model.dart';
import '../widget/confirmation_widget.dart';

class MedhecoinWithdrawalView extends StatefulWidget {
  const MedhecoinWithdrawalView({super.key});

  @override
  State<MedhecoinWithdrawalView> createState() =>
      _MedhecoinWithdrawalViewState();
}

class _MedhecoinWithdrawalViewState extends State<MedhecoinWithdrawalView> {
  late TextEditingController _accountNumberController;
  late TextEditingController _amountController;
  final TextEditingController _dropDownSearchController =
      TextEditingController();
  Color? amountFillColor = Colors.white70;
  Color? accountFillColor = Colors.white70;
  bool showConfirmation = false;

  final _formKey = GlobalKey<FormState>();
  void navigateToNext() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account verified'),
        ),
      );
      // Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController();
    _amountController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _accountNumberController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    final availableMedcoin =
        Provider.of<ReminderState>(context, listen: false).medcoin;
    final eqivalentMedcoin =
        Provider.of<ReminderState>(context, listen: false).medcoinInNaira;
    return Consumer<WalletViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            showConfirmation == true ? 'Confirmation' : 'Withdrawal',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (showConfirmation) {
                setState(() {
                  showConfirmation = false; // Return to withdrawal view
                });
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.navBarColor),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: showConfirmation == true
              ? buildConfirmWithdrawal(model)
              : buildWithdrawalForm(model, availableMedcoin),
        ),
      ),
    );
  }

  Widget buildWithdrawalForm(WalletViewModel model, int? availableMedcoin) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: SizeMg.height(130),
                  child: Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Saved Accounts',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeMg.text(14),
                          ),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              final item = model.walletModelList[index];
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: SizeMg.radius(25),
                                    child: Image.asset(
                                      item.src,
                                      width: 55,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Flexible(
                                    child: SizedBox(
                                      width: SizeMg.width(60),
                                      child: Text(
                                        item.firstName + ' ' + item.lastName,
                                        style: TextStyle(
                                          fontSize: SizeMg.text(12),
                                          color: AppColors.darkGrey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (ctx, index) => SizedBox(
                              height: SizeMg.width(15),
                            ),
                            itemCount: model.walletModelList.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Bank',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                DropDownSearchFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: this._dropDownSearchController,
                    decoration: kFormTextDecoration.copyWith(
                      errorBorder: kFormTextDecoration.errorBorder,
                      hintStyle: kFormTextDecoration.hintStyle,
                      hintText: 'Select Destination Bank',
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      border: kFormTextDecoration.border,
                      focusedBorder: kFormTextDecoration.focusedBorder,
                    ),
                  ),
                  suggestionsCallback: (pattern) {
                    return model.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      tileColor: kFormTextDecoration.fillColor,
                      title: Text(
                        suggestion,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {
                    _dropDownSearchController.text = suggestion;
                    model.selectedBank = suggestion;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a bank';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    model.selectedBank = value;
                  },
                  displayAllSuggestionWhenTap: true,
                ),
                SizedBox(height: 10),
                Text(
                  'Account Number',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: SizeMg.height(10),
                ),
                TextFormField(
                  controller: _accountNumberController,
                  cursorHeight: SizeMg.height(19),
                  decoration: kFormTextDecoration.copyWith(
                    errorBorder: kFormTextDecoration.errorBorder,
                    hintStyle: kFormTextDecoration.hintStyle,
                    border: kFormTextDecoration.border,
                    filled: true,
                    fillColor: accountFillColor,
                    focusedBorder: kFormTextDecoration.focusedBorder,
                    hintText: "Enter Account Number",
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.copy, color: AppColors.navBarColor),
                      iconSize: 24,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: _accountNumberController.text.isNotEmpty
                              ? _accountNumberController.text.trim()
                              : '',
                        ));
                        if (_accountNumberController.text.isNotEmpty)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Text copied to clipboard'),
                            ),
                          );
                      },
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                        10), // Limit input to 10 characters
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The account number must not be empty";
                    } else if (value.length < 10) {
                      return "Ensure to input a correct account number";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      if (value!.length == 10 && model.selectedBank != null) {
                        model.validateAccountNumber(model.selectedBank!, value);
                      }
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        accountFillColor = kFormTextDecoration.fillColor;
                      } else {
                        // If no input, set filled to false
                        model.accountOwnerName = null;
                        accountFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                if (model.accountOwnerName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${model.accountOwnerName}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: SizeMg.text(12),
                      ),
                    ),
                  ),
                SizedBox(height: SizeMg.height(10)),
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: SizeMg.height(10),
                ),
                TextFormField(
                  controller: _amountController,
                  cursorHeight: SizeMg.height(19),
                  decoration: kFormTextDecoration.copyWith(
                    errorBorder: kFormTextDecoration.errorBorder,
                    hintStyle: kFormTextDecoration.hintStyle,
                    border: kFormTextDecoration.border,
                    filled: true,
                    fillColor: amountFillColor,
                    focusedBorder: kFormTextDecoration.focusedBorder,
                    hintText: "Enter Amount to Withdraw",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The amount must not be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    model.updateAmount(value, availableMedcoin);
                    setState(() {
                      if (value.isNotEmpty) {
                        amountFillColor = kFormTextDecoration.fillColor;
                      } else {
                        amountFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                if (model.amountError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      model.amountError!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: SizeMg.text(12),
                      ),
                    ),
                  ),
                SizedBox(height: 5),
                Container(
                  width: SizeMg.screenWidth,
                  child: Row(
                    children: [
                      Text(
                        'Available',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          text: availableMedcoin.toString(),
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: ' MDHC',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: checkOutContainer(
            balance: availableMedcoin!,
            model: model,
            amount: model.amount?.toStringAsFixed(2) ?? '-----',
            transferFee: model.amount != null
                ? model.transferFee.toStringAsFixed(2)
                : '---',
            totalAmount: model.totalAmount?.toStringAsFixed(2) ?? '-----',
          ),
        ),
      ],
    );
  }

  // Widget buildConfirmWithdrawal(WalletViewModel model, int? balance) {
  //   String? validationError = model.validateWithdrawal(balance);
  //   if (validationError != null) {
  //     // Show error message if validation fails
  //     return CupertinoAlertDialog(
  //       title: Text('Error'),
  //       content: Text(validationError),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('OK'),
  //         ),
  //       ],
  //     );
  //   }

  //   return ConfirmWithdrawal(
  //     amount: model.amount?.toStringAsFixed(2) ?? '-----',
  //     transferFee: model.transferFee.toStringAsFixed(2),
  //     totalAmount: model.totalAmount?.toStringAsFixed(2) ?? '-----',
  //     receiverName: model.accountOwnerName ??
  //         'Joe Stephens ${_accountNumberController.text.trim()}',
  //     bankName: model.selectedBank ?? '',
  //     amountEquivalence:
  //         model.amountInNaira.toStringAsFixed(2), // Naira equivalency
  //     dateTime: StringUtils.checkToday(DateTime.now()),
  //   );
  // }

  Widget buildConfirmWithdrawal(WalletViewModel model) {
    return ConfirmWithdrawal(
      amount: model.amount?.toStringAsFixed(2) ?? '-----',
      transferFee: model.transferFee.toStringAsFixed(2),
      totalAmount: model.totalAmount?.toStringAsFixed(2) ?? '-----',
      receiverName: model.accountOwnerName ??
          'Joe Stephens ${_accountNumberController.text.trim()}',
      bankName: model.selectedBank ?? '',
      amountEquivalence: model.amountInNaira.toStringAsFixed(2),
      dateTime: StringUtils.checkToday(DateTime.now()),
    );
  }

  Widget checkOutContainer({
    WalletViewModel? model,
    required String amount,
    required String transferFee,
    required String totalAmount,
    required int balance,
  }) {
    return Container(
      child: Column(
        children: [
          Divider(color: AppColors.historyBackground),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: SizeMg.text(14),
                      ),
                    ),
                    SizedBox(),
                    RichText(
                      text: TextSpan(
                        text: '$amount MDHC',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeMg.text(16),
                          color: AppColors.blackGreen,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transfer fee',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: SizeMg.text(14),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '$transferFee MDHC',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeMg.text(16),
                          color: AppColors.blackGreen,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TotalAmount',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: SizeMg.text(14),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '$totalAmount MDHC',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeMg.text(16),
                          color: AppColors.blackGreen,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  buttonConfig: ButtonConfig(
                    text: 'Checkout',
                    action: () {
                      String? validationError =
                          model?.validateWithdrawal(balance);
                      if (validationError == null &&
                          model?.amountError == null &&
                          _formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Account verified'),
                          ),
                        );
                        setState(() {
                          showConfirmation = true;
                        });
                      } else if (validationError != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Error',
                              style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeMg.text(18),
                              ),
                            ),
                            content: Text(
                              validationError != null
                                  ? validationError.toString()
                                  : 'Something went wrong',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeMg.text(14),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  width: SizeMg.screenWidth,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
