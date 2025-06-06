import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manafea/config/appColors.dart';
import 'package:manafea/config/appConstants.dart';
import 'package:manafea/domain/models/baseOrderModel/baseOrderModel.dart';
import 'package:manafea/ui/core/shared_widget/elevatedButton.dart';

import '../../../../generated/locale_keys.g.dart';

class OrderItem extends StatefulWidget {
  OrderItem({
    super.key,
    required this.order,
    required this.orderDetailedChanged,
    required this.cancelOrder,
    required this.orderType,
    required this.orderName,
  });

  BaseOrder order;
  Widget orderDetailedChanged;
  String orderType;
  String orderName;
  Function(String) cancelOrder;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(AppConstants.screenWidth*0.047),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.screenWidth*0.036),
        child: Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.screenWidth*0.036),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildOrderHeader(),
              const Divider(thickness: 1, color: Colors.grey),
              widget.orderDetailedChanged,
              ClipRRect(
                borderRadius:
                      BorderRadius.vertical
                      (bottom: Radius.circular(AppConstants.screenWidth*0.036)),
                child: SizedBox(
                  width: double.infinity,
                  height: AppConstants.screenHeight * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape:   RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom:
                            Radius.circular(AppConstants.screenWidth*0.036)),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => buildCancelWidget());
                    },
                    child:   Text(LocaleKeys.buttons_name_cancel_order.tr(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.order.id,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.screenWidth * 0.038,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${LocaleKeys.orders_screen_total_price.tr()}: ${widget.order.price}\$",
                style: TextStyle(
                  fontSize: AppConstants.screenWidth * 0.032,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[700],
                )
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => orderInfo(),
                );
              },
              child: Icon(Icons.info_outline_rounded,
                  color: Colors.grey[700], size: 22)),
        ],
      ),
    );
  }

  Widget orderInfo() {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: PhysicalModel(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.screenWidth * 0.036 ),
        child: Container(
          height: AppConstants.screenHeight * 0.35,
          width: AppConstants.screenWidth * 0.85,
          // Adjusted width to fit better
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:   EdgeInsets.all(AppConstants.screenWidth * 0.044),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoDataWidget( LocaleKeys.orders_screen_name.tr(), widget.order.name),
                infoDataWidget(LocaleKeys.orders_screen_phone.tr(), widget.order.phoneNumber),
                infoDataWidget('Time', widget.order.time),
                infoDataWidget(LocaleKeys.orders_screen_payment_method.tr(), 'Cash'),
                infoDataWidget(widget.orderType, widget.orderName),
                  SizedBox(height: AppConstants.screenHeight * 0.02 ),
                // Close the dialog
                elevated_button(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonName: LocaleKeys.buttons_name_ok.tr(),
                    valid: true,

                    buttonSize: Size(

                        AppConstants.screenWidth,
                        AppConstants.screenHeight * 0.05))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoDataWidget(String title, String data) {
    return Padding(
      padding:   EdgeInsets.symmetric(
          horizontal: AppConstants.screenWidth * 0.036
          , vertical: AppConstants.screenHeight * 0.008 ),
      child: Row(
        children: [
          Text(
            "$title:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.screenWidth * 0.038,
            ),
          ),
            SizedBox(width: AppConstants.screenWidth * 0.017 ),
          Expanded(
            child: Text(
              data,
              style: TextStyle(
                fontSize: AppConstants.screenWidth * 0.036,
                color: AppColors.primaryColor, // Customize text color
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: false, // Avoid wrapping the text
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCancelWidget() {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: PhysicalModel(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.screenWidth*0.036),
        child: Container(
          height: AppConstants.screenHeight * 0.37,
          width: AppConstants.screenWidth * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.screenWidth*0.044
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '😠',
                  style: TextStyle(fontSize: AppConstants.screenWidth*0.23),
                ),
                Text(
                LocaleKeys.buttons_name_cancel_order.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.screenWidth * 0.053,
                  ),
                ),
                  Text(
                  LocaleKeys.orders_screen_cancel_order_confirmation.tr(),

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppConstants.screenWidth * 0.039 ,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: AppConstants.screenHeight * 0.01 ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        widget.cancelOrder(widget.order.id);
                        // Action when user presses Yes
                        Navigator.pop(context, true);
                      },
                      child:   Text(
LocaleKeys.buttons_name_yes.tr()
                        ,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Action when user presses No
                        Navigator.pop(context, false);
                      },
                      child: Text(LocaleKeys.buttons_name_no.tr()),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppConstants.screenHeight * 0.03 ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
