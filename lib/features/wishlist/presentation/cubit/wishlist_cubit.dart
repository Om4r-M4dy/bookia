import 'package:bookia/features/Home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  List<Product> wishlist = [];

  Future<void> getWishlist() async {
    emit(WishlistLoadingState());
    var response = await WishlistRepo.getWishlist();
    if (response != null && response.data != null) {
      wishlist = response.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState(error: 'Failed to load wishlist'));
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistLoadingState());
    var response = await WishlistRepo.removeFromWishlist(productId);
    if (response != null && response.data != null) {
      await getWishlist();
      emit(WishlistSuccessState(message: response.message ?? ''));
    } else {
      emit(WishlistErrorState(error: 'Failed to remove from wishlist'));
    }
  }
}
