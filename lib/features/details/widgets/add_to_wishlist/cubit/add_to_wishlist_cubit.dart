import 'package:bookia/core/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/details/widgets/add_to_wishlist/cubit/add_to_wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  WishlistActionCubit() : super(WishlistActionInitialState());

  Future<void> addToWishlist(int productId) async {
    emit(WishlistActionLoadingState());
    var response = await WishlistRepo.addToWishlist(productId);
    if (response != null && response.data != null) {
      emit(WishlistActionSuccessState(message: response.message ?? 'Success'));
    } else {
      emit(WishlistActionErrorState(error: 'Failed to add to wishlist'));
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistActionLoadingState());
    var response = await WishlistRepo.removeFromWishlist(productId);
    if (response != null && response.data != null) {
      emit(WishlistActionSuccessState(message: response.message ?? 'Success'));
    } else {
      emit(WishlistActionErrorState(error: 'Failed to remove from wishlist'));
    }
  }

  bool isProductInWishlist(int productId) {
    return SharedPref.getWishlistIds().contains(productId.toString());
  }
}
