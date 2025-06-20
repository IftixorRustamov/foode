import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';

class Order {
  final List<CartItem> items;
  final DateTime timestamp;
  final String status;

  Order({required this.items, required this.timestamp, this.status = 'Process'});
}

class OrderHistoryState {
  final List<Order> orders;
  OrderHistoryState(this.orders);
}

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryState([]));

  void addOrder(List<CartItem> items) {
    final order = Order(items: List<CartItem>.from(items), timestamp: DateTime.now());
    emit(OrderHistoryState([order, ...state.orders]));
  }

  void clear() {
    emit(OrderHistoryState([]));
  }
} 