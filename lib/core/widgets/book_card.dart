import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/Home/data/models/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.heroTag,
    this.onRemovePressed,
    this.onRefresh,
  });
  final String heroTag;
  final Product book;
  final VoidCallback? onRemovePressed;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(
          context,
          Routes.details,
          extra: {'book': book, 'heroTag': heroTag},
        ).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: book.image ?? "",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Gap(5),
            Text(
              book.name ?? "",
              style: TextStyles.subtitle2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${book.priceAfterDiscount ?? book.price}',
                  style: TextStyles.body,
                ),
                onRemovePressed != null
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: onRemovePressed,
                        icon: Icon(Icons.close, size: 18),
                      )
                    : MainButton(
                        minWidth: 72,
                        minHeight: 28,
                        bgColor: AppColors.darkColor,
                        text: 'buy',
                        onPressed: () {},
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
