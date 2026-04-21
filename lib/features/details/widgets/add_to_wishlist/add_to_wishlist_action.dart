import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/details/widgets/add_to_wishlist/cubit/add_to_wishlist_cubit.dart';
import 'package:bookia/features/details/widgets/add_to_wishlist/cubit/add_to_wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToWishlistAction extends StatelessWidget {
  const AddToWishlistAction({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionCubit(),
      child: BlocConsumer<WishlistActionCubit, WishlistActionState>(
        listener: (context, state) {
          if (state is WishlistActionSuccessState) {
            pop(context);
            showMessageDialog(context, state.message, DialogType.success);
          } else if (state is WishlistActionErrorState) {
            pop(context);
            showMessageDialog(context, state.error);
          } else if (state is WishlistActionLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              if (context.read<WishlistActionCubit>().isProductInWishlist(
                productId,
              )) {
                context.read<WishlistActionCubit>().removeFromWishlist(
                  productId,
                );
              } else {
                context.read<WishlistActionCubit>().addToWishlist(productId);
              }
            },
            icon: CustomSvgPicture(
              path: AppImages.bookmarkSvg,
              color:
                  context.read<WishlistActionCubit>().isProductInWishlist(
                    productId,
                  )
                  ? AppColors.primaryColor
                  : null,
            ),
          );
        },
      ),
    );
  }
}
