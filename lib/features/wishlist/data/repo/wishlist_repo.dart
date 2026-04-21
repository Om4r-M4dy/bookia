import 'package:bookia/core/local/shared_pref.dart';
import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/wishlist_response.dart';

class WishlistRepo {
  static Future<WishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.wishlist,
        headers: {'Authorization': 'Bearer ${SharedPref.getToken()}'},
      );
      if (response.statusCode == 200) {
        var data = WishlistResponse.fromJson(response.data);
        SharedPref.setWishlistIds(
          data.data?.data?.map((e) => e.id.toString()).toList() ?? [],
        );
        return data;
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<WishlistResponse?> addToWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.addToWishlist,
        data: {'product_id': productId},
        headers: {'Authorization': 'Bearer ${SharedPref.getToken()}'},
      );
      if (response.statusCode == 200) {
        SharedPref.addWishlistId(productId.toString());
        return WishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<WishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.removeFromWishlist,
        data: {'product_id': productId},
        headers: {'Authorization': 'Bearer ${SharedPref.getToken()}'},
      );
      if (response.statusCode == 200) {
        SharedPref.removeWishlistId(productId.toString());
        return WishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
