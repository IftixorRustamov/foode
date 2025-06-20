import 'package:flutter/material.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import '../screens/find_food_screen.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          suffixIcon: IconButton(
            icon: Icon(Icons.filter_list, color: Colors.pink),
            onPressed: () {
              CustomRouter.go(FindFoodScreen());
            },
          ),
        ),
      ),
    );
  }
} 