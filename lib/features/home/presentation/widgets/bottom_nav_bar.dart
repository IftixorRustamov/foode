import 'package:flutter/material.dart';
import 'package:uic_task/features/home/presentation/screens/home_screen.dart';
import 'package:uic_task/features/orders/presentation/orders_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../orders/presentation/bloc/cart_bloc.dart';
import '../../../orders/presentation/order_history_screen.dart';
import '../../../chat/presentation/screens/chat_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    OrderHistoryScreen(),
    ChatListScreen(),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> labels = ['Home', 'Shop', 'Messages', 'Profile'];
  final List<String> icons = [
    'assets/images/home.png',
    'assets/images/shop.png',
    'assets/images/message.png',
    'assets/images/person.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final count = state.items.fold<int>(
            0,
            (sum, item) => sum + item.quantity,
          );
          return Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => OrderDetailsScreen()),
                  );
                },
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              if (count > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.08),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final bool isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 16 : 0,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.pink.shade50
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        icons[index],
                        height: 38,
                        width: 44,
                        color: AppColors.primary,
                      ),
                      if (isSelected) SizedBox(width: 6),
                      if (isSelected)
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
