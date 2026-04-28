import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  String? total;
  List<CartItem> cartItems = [];

  Future<void> getCart() async {
    emit(CartLoadingState());
    var response = await CartRepo.getCart();
    if (response != null && response.data?.cartItems != null) {
      total = response.data?.total.toString();
      cartItems = response.data?.cartItems ?? [];
      emit(CartLoadedState());
    } else {
      emit(CartErrorState(error: "Failed to load cart"));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    var item = cartItems.firstWhere((element) => element.itemId == cartItemId);
    cartItems.remove(item);
    if (total != null) {
      total = (double.tryParse(total!) ?? 0.0 - (item.itemTotal ?? 0.0))
          .toString();
    }
    emit(CartLoadedState());
    var response = await CartRepo.removeFromCart(cartItemId);
    if (response != null && response.data?.cartItems != null) {
      total = response.data?.total.toString();
      cartItems = response.data?.cartItems ?? [];
      emit(CartLoadedState());
    } else {
      cartItems.add(item);
      if (total != null) {
        total = (double.tryParse(total!) ?? 0.0 + (item.itemTotal ?? 0.0))
            .toString();
      }
      emit(CartErrorState(error: "Failed to remove from cart"));
    }
  }

  Future<void> updateCart(int cartItemId, int quantity) async {
    var item = cartItems.firstWhere((element) => element.itemId == cartItemId);
    
    int oldQuantity = item.itemQuantity ?? 0;
    int newQuantity = quantity;
    item.itemQuantity = newQuantity;

    double oldTotal = item.itemTotal ?? 0.0;
    double newTotal = quantity *
        (double.tryParse(item.itemProductPrice ?? '0') ?? 0.0);
    item.itemTotal = newTotal;

    if (total != null) {
      total = ((double.tryParse(total!) ?? 0.0) + (newTotal - oldTotal))
          .toString();
    }
    emit(CartLoadedState());
    var response = await CartRepo.updateCart(cartItemId, quantity);
    if (response != null && response.data?.cartItems != null) {
      total = response.data?.total.toString();
      cartItems = response.data?.cartItems ?? [];
      emit(CartLoadedState());
    } else {
      item.itemQuantity = oldQuantity;
      item.itemTotal = oldTotal;
      if (total != null) {
        total = ((double.tryParse(total!) ?? 0.0) + (oldTotal - newTotal))
            .toString();
      }
      emit(CartErrorState(error: "Failed to update cart"));
    }
  }
}
