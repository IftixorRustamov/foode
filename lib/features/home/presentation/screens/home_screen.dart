import 'package:flutter/material.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/home/presentation/screens/popular_menu_screen.dart';
import 'package:uic_task/features/home/presentation/screens/popular_restaurant_screen.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/promo_banner.dart';
import '../widgets/popular_restaurant_list.dart';
import '../widgets/popular_menu_list.dart';
import 'package:uic_task/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.fastfood, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text(
              'Hello, Daniel !',
              style: textStyles.semiBold(color: Colors.black87, fontSize: 20),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSearchBar(),
            SizedBox(height: appH(16)),
            PromoBanner(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Restaurant',
                  style: textStyles.semiBold(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CustomRouter.go(PopularRestaurant());
                  },
                  child: Text(
                    'See all',
                    style: textStyles.regular(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: appH(6)),
            PopularRestaurantList(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Menu',
                  style: textStyles.semiBold(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CustomRouter.go(PopularMenuScreen());
                  },
                  child: Text(
                    'See all',
                    style: textStyles.regular(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            PopularMenuList(),
          ],
        ),
      ),
    );
  }
}
