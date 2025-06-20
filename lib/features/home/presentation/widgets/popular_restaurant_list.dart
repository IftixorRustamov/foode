import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurant_card.dart';
import '../../../../core/utils/responsiveness/app_responsive.dart';

class PopularRestaurantList extends StatelessWidget {
  const PopularRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('restaurants').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No restaurants found'));
        }

        final docs = snapshot.data!.docs;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: docs.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
              final data = doc.data() as Map<String, dynamic>;
              return Row(
                children: [
                  RestaurantCard(
                    data['image'] ?? '',
                    data['name'] ?? '',
                    data['time'] ?? '',
                  ),
                  if (index < docs.length - 1) SizedBox(width: appW(16)),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
