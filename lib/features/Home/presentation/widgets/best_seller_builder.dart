import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/grid_shimmer.dart';
import 'package:bookia/features/Home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/Home/presentation/cubit/home_state.dart';
import 'package:bookia/features/Home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSellerBuilder extends StatelessWidget {
  const BestSellerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var books = context.read<HomeCubit>().bestSellers;
        if (state is HomeLoadingState || state is HomeInitialState) {
          return const MyBodyView(child: GridShimmer());
        }
        return MyBodyView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Best Seller', style: TextStyles.title),
              Gap(20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) => BookCard(
                  book: books[index],
                  heroTag: 'home_${books[index].id}',
                ),
                itemCount: books.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
