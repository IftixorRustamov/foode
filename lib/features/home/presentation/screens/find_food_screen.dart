import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/menu_card.dart';

class FindFoodScreen extends StatefulWidget {
  const FindFoodScreen({super.key});

  @override
  State<FindFoodScreen> createState() => _FindFoodScreenState();
}

class _FindFoodScreenState extends State<FindFoodScreen> {
  String? _selectedType;
  String? _selectedLocation;
  String? _selectedFood;
  String _searchText = '';
  bool _showResults = false;
  List<QueryDocumentSnapshot>? _results;
  bool _loading = false;
  String? _error;

  void _onSearch() async {
    setState(() {
      _loading = true;
      _showResults = false;
      _error = null;
    });
    try {
      Query query;
      if (_selectedType == 'Restaurant') {
        query = FirebaseFirestore.instance.collection('restaurants');
        if (_searchText.isNotEmpty) {
          query = query.where('name', isGreaterThanOrEqualTo: _searchText).where('name', isLessThanOrEqualTo: _searchText + '\uf8ff');
        }
        // You can add more filters for location if you store location info in Firestore
      } else {
        query = FirebaseFirestore.instance.collection('menus');
        if (_searchText.isNotEmpty) {
          query = query.where('title', isGreaterThanOrEqualTo: _searchText).where('title', isLessThanOrEqualTo: _searchText + '\uf8ff');
        }
        if (_selectedFood != null) {
          query = query.where('category', isEqualTo: _selectedFood);
        }
      }
      final snapshot = await query.get();
      setState(() {
        _results = snapshot.docs;
        _showResults = true;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _resetFilters() {
    setState(() {
      _showResults = false;
      _results = null;
      _loading = false;
      _error = null;
    });
  }

  Widget _buildFilterChips() {
    List<Widget> chips = [];
    if (_selectedType != null) {
      chips.add(_buildChip(_selectedType!, () => setState(() => _selectedType = null)));
    }
    if (_selectedFood != null) {
      chips.add(_buildChip(_selectedFood!, () => setState(() => _selectedFood = null)));
    }
    if (_selectedLocation != null) {
      chips.add(_buildChip(_selectedLocation!, () => setState(() => _selectedLocation = null)));
    }
    return Wrap(
      spacing: appW(10),
      runSpacing: appH(10),
      children: chips,
    );
  }

  Widget _buildChip(String label, VoidCallback onDeleted) {
    return Chip(
      label: Text(label, style: TextStyle(color: AppColors.white)),
      backgroundColor: AppColors.primary,
      deleteIcon: Icon(Icons.close, color: Colors.white, size: 18),
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }

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
          child: _showResults ? _buildResultsView(textStyles) : _buildFilterView(textStyles),
        ),
      ),
    );
  }

  Widget _buildFilterView(AppTextStyles textStyles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearchField(),
        SizedBox(height: appH(18)),
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
        SizedBox(height: appH(18)),
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
        SizedBox(height: appH(18)),
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
        DefaultButton(text: 'Search', onPressed: _onSearch),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (_error != null) Center(child: Text(_error!)),
      ],
    );
  }

  Widget _buildResultsView(AppTextStyles textStyles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: appH(8)),
        _buildFilterChips(),
        SizedBox(height: appH(18)),
        if (_loading) const Center(child: CircularProgressIndicator()),
        if (_error != null) Center(child: Text(_error!)),
        if (_results == null || _results!.isEmpty)
          Expanded(child: Center(child: Text('No results found')))
        else if (_selectedType == 'Restaurant')
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: appW(16),
                mainAxisSpacing: appH(16),
                childAspectRatio: 1,
              ),
              itemCount: _results!.length,
              itemBuilder: (context, index) {
                final data = _results![index].data() as Map<String, dynamic>;
                return RestaurantCard(
                  data['image'] ?? '',
                  data['name'] ?? '',
                  data['time'] ?? '',
                );
              },
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: _results!.length,
              itemBuilder: (context, index) {
                final data = _results![index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FoodCard(
                    imagePath: data['image'] ?? '',
                    title: data['title'] ?? '',
                    subtitle: data['subtitle'] ?? '',
                    price: data['price']?.toString() ?? '',
                  ),
                );
              },
            ),
          ),
        SizedBox(height: appH(18)),
        DefaultButton(
          text: 'Change filters',
          onPressed: _resetFilters,
        ),
      ],
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
        onChanged: (value) {
          _searchText = value;
        },
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
