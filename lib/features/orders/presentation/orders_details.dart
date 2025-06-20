import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../core/common/widgets/button/default_button.dart';
import '../../../core/utils/responsiveness/app_responsive.dart';
import '../widgets/cart_box.dart';
import '../widgets/cart_item.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart_bloc.dart';
import 'order_history_screen.dart';
import 'bloc/order_history_cubit.dart';

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
            SizedBox(height: appH(28)),
            CartItemCard(
              image: "assets/images/freshsalad.png",
              title: "Fresh Salad",
              subtitle: "Recto Food",
              price: 10,
              quantity: 1,
              onAdd: () {},
              onRemove: () {},
            ),
            SizedBox(height: appH(28)),
            CartItemCard(
              image: "assets/images/freshsalad.png",
              title: "Grenny Salad",
              subtitle: "Circlo Food",
              price: 12,
              quantity: 1,
              onAdd: () {},
              onRemove: () {},
            ),
            SizedBox(height: appH(28)),
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

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: CustomRouter.close,
        titleText: 'Order details',
      ),
      body: Padding(
        padding: btm48,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final items = state.items;
            double delivery = 5;
            double discount = 10;
            double subtotal = state.subtotal;
            double total = subtotal + delivery - discount;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: appW(16)),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list,
                            color: AppColors.primary,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: appH(24)),
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: appH(18)),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _OrderDetailsItem(item: item);
                    },
                  ),
                ),
                SizedBox(height: appH(18)),
                _OrderSummary(
                  subtotal: subtotal,
                  delivery: delivery,
                  discount: discount,
                  total: total,
                ),
                SizedBox(height: appH(18)),
                DefaultButton(
                  text: 'Place my order',
                  onPressed: items.isEmpty ? null : () {
                    context.read<OrderHistoryCubit>().addOrder(items);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Order placed!')));
                    BlocProvider.of<CartBloc>(context).add(ClearCart());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderDetailsItem extends StatelessWidget {
  final CartItem item;

  const _OrderDetailsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image,
              height: appH(56),
              width: appW(56),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: appW(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: textStyles.semiBold(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: textStyles.regular(
                    fontSize: 14,
                    color: AppColors.neutral4,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  ' 24${item.price}',
                  style: textStyles.semiBold(
                    fontSize: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle, color: AppColors.primary),
                onPressed: () {
                  if (item.quantity > 1) {
                    BlocProvider.of<CartBloc>(
                      context,
                    ).add(ChangeQuantity(item.id, item.quantity - 1));
                  } else {
                    BlocProvider.of<CartBloc>(
                      context,
                    ).add(RemoveFromCart(item.id));
                  }
                },
              ),
              Text(
                '${item.quantity}',
                style: textStyles.semiBold(fontSize: 18, color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: AppColors.primary),
                onPressed: () {
                  BlocProvider.of<CartBloc>(
                    context,
                  ).add(ChangeQuantity(item.id, item.quantity + 1));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final double subtotal;
  final double delivery;
  final double discount;
  final double total;

  const _OrderSummary({
    required this.subtotal,
    required this.delivery,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.9), AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _summaryRow('Subtotal', subtotal, textStyles),
          SizedBox(height: 8),
          _summaryRow('Delivery charge', delivery, textStyles),
          SizedBox(height: 8),
          _summaryRow('Discount', discount, textStyles),
          Divider(color: Colors.white, height: 24),
          _summaryRow('Total', total, textStyles, isTotal: true),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value,
    AppTextStyles textStyles, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textStyles.regular(
            color: Colors.white,
            fontSize: isTotal ? 18 : 15,
          ),
        ),
        Text(
          ' 24${value.toStringAsFixed(0)}',
          style: textStyles.semiBold(
            color: Colors.white,
            fontSize: isTotal ? 20 : 16,
          ),
        ),
      ],
    );
  }
}
