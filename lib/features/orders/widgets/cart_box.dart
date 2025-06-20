import 'package:flutter/material.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';

import '../../../core/common/constants/colors/app_colors.dart';

class CartSummaryBox extends StatelessWidget {
  final int subtotal;
  final int delivery;
  final int discount;
  final VoidCallback onPlaceOrder;

  const CartSummaryBox({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.discount,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final int total = subtotal + delivery - discount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.pinkAccent, AppColors.tertiary2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _row("Subtotal", "\$$subtotal"),
          _row("Delivery charge", "\$$delivery"),
          _row("Discount", "\$$discount"),
           Divider(color: Colors.white60, height: appH(24)),
          _row("Total", "\$$total", isBold: true),
           SizedBox(height: appH(20)),
          ElevatedButton(
            onPressed: onPlaceOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              padding:  EdgeInsets.symmetric(horizontal: appH(90), vertical: 16),
            ),
            child:  Text(
              "Place my order",
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold ,
              )),
          Text(value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight:  FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
