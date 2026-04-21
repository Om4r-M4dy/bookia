class WishlistActionState {}

class WishlistActionInitialState extends WishlistActionState {}

class WishlistActionLoadingState extends WishlistActionState {}

class WishlistActionSuccessState extends WishlistActionState {
  final String message;
  WishlistActionSuccessState({required this.message});
}

class WishlistActionErrorState extends WishlistActionState {
  final String error;
  WishlistActionErrorState({required this.error});
}
