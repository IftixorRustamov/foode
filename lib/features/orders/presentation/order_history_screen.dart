import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';
import 'bloc/order_history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: appW(12)),
          child: CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Icon(Icons.menu, color: AppColors.primary),
          ),
        ),
        title: Text('Order History', style: textStyles.bold(fontSize: 24, color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(appW(20)),
        child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            final nonEmptyOrders = state.orders.where((order) => order.items.isNotEmpty).toList();
            if (nonEmptyOrders.isEmpty) {
              return Center(child: Text('No orders yet.'));
            }
            return ListView.separated(
              itemCount: nonEmptyOrders.length,
              separatorBuilder: (_, __) => SizedBox(height: appH(18)),
              itemBuilder: (context, index) {
                final order = nonEmptyOrders[index];
                final firstItem = order.items.first;
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
                          firstItem.image,
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
                            Text(firstItem.title, style: textStyles.semiBold(fontSize: 18, color: Colors.black)),
                            SizedBox(height: 4),
                            Text(firstItem.subtitle, style: textStyles.regular(fontSize: 14, color: AppColors.neutral4)),
                            SizedBox(height: 6),
                            Text('\$${firstItem.price}', style: textStyles.semiBold(fontSize: 18, color: Colors.redAccent)),
                            SizedBox(height: 6),
                            Text('Ordered: ' + order.timestamp.toLocal().toString().split('.')[0], style: textStyles.regular(fontSize: 12, color: AppColors.neutral4)),
                          ],
                        ),
                      ),
                      _buildStatusChip(order.status, textStyles),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, AppTextStyles textStyles) {
    Color color;
    String label = status;
    switch (status) {
      case 'Process':
        color = Colors.green;
        break;
      case 'Completed':
        color = Colors.blue;
        break;
      case 'Canceled':
        color = Colors.red;
        break;
      default:
        color = AppColors.primary;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: textStyles.semiBold(color: color, fontSize: 15),
      ),
    );
  }
} 