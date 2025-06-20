import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

class FindFoodScreen extends StatefulWidget {
  const FindFoodScreen({super.key});

  @override
  State<FindFoodScreen> createState() => _FindFoodScreenState();
}

class _FindFoodScreenState extends State<FindFoodScreen> {
  String? _selectedType;
  String? _selectedLocation;
  String? _selectedFood;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ActionAppBarWg(
          onBackPressed: () => CustomRouter.close(),
          titleText: "Find your food",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(appW(20)),
          child: Column(
            spacing: appH(24),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              _buildFilterSection(
                title: 'Type',
                options: ['Restaurant', 'Menu'],
                selectedValue: _selectedType,
                onSelected: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              _buildFilterSection(
                title: 'Location',
                options: ['1 km', '< 5 km', '< 10 km', '> 10 km'],
                selectedValue: _selectedLocation,
                onSelected: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),
              _buildFilterSection(
                title: 'Food',
                options: [
                  'Cake',
                  'Salad',
                  'Pasta',
                  'Desert',
                  'Main course',
                  'Appetizer',
                  'Soup',
                ],
                selectedValue: _selectedFood,
                onSelected: (value) {
                  setState(() {
                    _selectedFood = value;
                  });
                },
              ),
              const Spacer(),
              DefaultButton(text: 'Search', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: appW(12)),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.filter_list, color: AppColors.primary),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyles.semiBold(fontSize: 18, color: AppColors.black),
        ),
        SizedBox(height: appH(12)),
        Wrap(
          spacing: appW(12),
          runSpacing: appH(12),
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appW(20),
                  vertical: appH(12),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  option,
                  style: textStyles.regular(
                    color: isSelected ? AppColors.white : AppColors.primary,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
