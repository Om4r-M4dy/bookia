import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/features/Home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/details/widgets/add_to_cart/add_cart_button.dart';
import 'package:bookia/features/details/widgets/add_to_wishlist/add_to_wishlist_action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book, required this.heroTag});
  final Product book;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                pop(context);
              },
              child: CustomSvgPicture(path: AppImages.backSvg),
            ),
          ],
        ),
        actions: [AddToWishlistAction(productId: book.id ?? 0)],
      ),
      body: _detailsBody(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${book.priceAfterDiscount ?? book.price}',
              style: TextStyles.body,
            ),
            AddCartButton(bookId: book.id ?? 0),
          ],
        ),
      ),
    );
  }

  Widget _detailsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: MyBodyView(
          child: Column(
            children: [
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: book.image ?? "",
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Gap(30),
              Text(
                book.name ?? '',
                style: TextStyles.headline,
                textAlign: TextAlign.center,
              ),
              Gap(10),
              Text(
                book.category ?? '',
                style: TextStyles.body.copyWith(color: AppColors.primaryColor),
              ),
              Gap(20),
              ReadMoreText(
                book.description ?? '',
                style: TextStyles.caption1,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Length,
                trimLines: 4,
                colorClickableText: AppColors.primaryColor,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
