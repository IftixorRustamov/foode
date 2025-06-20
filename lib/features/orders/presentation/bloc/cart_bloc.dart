import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem {
  final String id;
  final String image;
  final String title;
  final String subtitle;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) => CartItem(
        id: id,
        image: image,
        title: title,
        subtitle: subtitle,
        price: price,
        quantity: quantity ?? this.quantity,
      );
}

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final String id;
  RemoveFromCart(this.id);
}

class ChangeQuantity extends CartEvent {
  final String id;
  final int quantity;
  ChangeQuantity(this.id, this.quantity);
}

class ClearCart extends CartEvent {}

class CartState {
  final List<CartItem> items;
  CartState(this.items);

  double get subtotal => items.fold(0, (sum, item) => sum + item.price * item.quantity);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>((event, emit) {
      final existing = state.items.indexWhere((i) => i.id == event.item.id);
      if (existing != -1) {
        final updated = List<CartItem>.from(state.items);
        updated[existing] = updated[existing].copyWith(quantity: updated[existing].quantity + event.item.quantity);
        emit(CartState(updated));
      } else {
        emit(CartState([...state.items, event.item]));
      }
    });
    on<RemoveFromCart>((event, emit) {
      emit(CartState(state.items.where((i) => i.id != event.id).toList()));
    });
    on<ChangeQuantity>((event, emit) {
      final updated = state.items.map((i) =>
        i.id == event.id ? i.copyWith(quantity: event.quantity) : i
      ).where((i) => i.quantity > 0).toList();
      emit(CartState(updated));
    });
    on<ClearCart>((event, emit) => emit(CartState([])));
  }
} 