import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/models/search_model.dart';
import 'package:shop_app1/modules/search/cubit/states.dart';
import 'package:shop_app1/network/end_points.dart';
import 'package:shop_app1/network/remote/dio_helper.dart';
import 'package:shop_app1/shared/constants/constants.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearch({required String text}) {
   emit(ShopSearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token : token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState(error.toString()));
    });
  }

}