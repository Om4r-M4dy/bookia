import 'package:bookia/features/Home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/Home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/Home/data/models/slider_response/slider.dart';
import 'package:bookia/features/Home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/Home/data/repository/home_repo.dart';
import 'package:bookia/features/Home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Slider> sliders = [];
  List<Product> bestSellers = [];

  Future<void> getInitData() async {
    emit(HomeLoadingState());
    var results = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.getBestSellers(),
    ]);
    var slidersRes = results[0] as SliderResponse?;
    var bestSellersRes = results[1] as BestSellerResponse?;
    if (slidersRes != null || bestSellersRes != null) {
      sliders = slidersRes?.data?.sliders ?? [];
      bestSellers = bestSellersRes?.data?.products ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }
}
