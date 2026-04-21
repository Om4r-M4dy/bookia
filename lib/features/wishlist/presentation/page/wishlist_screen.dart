import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/grid_shimmer.dart';
import 'package:bookia/core/widgets/book_card.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist', style: TextStyles.title)),
      body: MyBodyView(
        child: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            var book = context.read<WishlistCubit>().wishlist;
            if (state is! WishlistSuccessState) {
              return GridShimmer();
            }
            if (book.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture(
                      path: AppImages.bookmarkSvg,
                      height: 100,
                      width: 100,
                      color: AppColors.darkGreyColor,
                    ),
                    Gap(20),
                    Text(
                      'Your wishlist is empty',
                      style: TextStyles.subtitle2.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                    Gap(50),
                  ],
                ),
              );
            }
            return GridView.builder(
              itemCount: book.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 250,
              ),
              itemBuilder: (context, index) => BookCard(
                book: book[index],
                heroTag: 'search_${book[index].id}',
                onRemovePressed: () {
                  context.read<WishlistCubit>().removeFromWishlist(
                    book[index].id!,
                  );
                },
                onRefresh: () {
                  context.read<WishlistCubit>().getWishlist();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
