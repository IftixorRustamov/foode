import 'package:flutter/material.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../core/utils/responsiveness/app_responsive.dart';
import '../widgets/cart_box.dart';
import '../widgets/cart_item.dart';

class OrdersDetails extends StatelessWidget {
  OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 16),
            // Title
            const Text(
              'Order details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Icon(Icons.filter_list, color: AppColors.primary),
                ),
              ),
            ),
            SizedBox(height: appH(22)),
            CartItemCard(
              image: "assets/images/salad.png",
              title: "Original Salad",
              subtitle: "Lovy Food",
              price: 10,
              quantity: 1,
              onAdd: () {},
              onRemove: () {},
            ),
            SizedBox(height: appH(28),),
            CartItemCard(
              image: "assets/images/freshsalad.png",
              title: "Fresh Salad",
              subtitle: "Recto Food",
              price: 10,
              quantity: 1,
              onAdd: () {},
              onRemove: () {},
            ),
            SizedBox(height: appH(28),),
            CartItemCard(
              image: "assets/images/freshsalad.png",
              title: "Grenny Salad",
              subtitle: "Circlo Food",
              price: 12,
              quantity: 1,
              onAdd: () {},
              onRemove: () {},
            ),
            SizedBox(height: appH(28),),
            CartSummaryBox(
              subtotal: 32,
              delivery: 5,
              discount: 10,
              onPlaceOrder: () {
                print("Order placed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
