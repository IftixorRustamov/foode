import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../orders/presentation/bloc/cart_bloc.dart';
import 'menu_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/features/orders/presentation/orders_details.dart';

class PopularMenuList extends StatelessWidget {
  const PopularMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('menus').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No menus found'));
        }
        
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: FoodCard(
                imagePath: data['image'] ?? '',
                title: data['title'] ?? '',
                subtitle: data['subtitle'] ?? '',
                price: data['price']?.toString() ?? '',
                onTap: () {
                  final cartItem = CartItem(
                    id: doc.id,
                    image: data['image'] ?? '',
                    title: data['title'] ?? '',
                    subtitle: data['subtitle'] ?? '',
                    price: double.tryParse(data['price']?.toString() ?? '0') ?? 0,
                  );
                  BlocProvider.of<CartBloc>(context).add(AddToCart(cartItem));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${data['title']} added to cart!')),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
} 