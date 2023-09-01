import 'package:shop_app1/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeModeState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

// HomeData
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

// Categories
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

// Favorites
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String error;
  ShopErrorGetFavoritesState(this.error);
}


// User Profile
class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;
  ShopErrorGetUserDataState(this.error);
}

// Update User
class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;
  ShopErrorUpdateUserState(this.error);
}


// Search
class ShopGetSearchLoadingState extends ShopStates {}

class ShopGetSearchSuccessState extends ShopStates {}

class ShopGetSearchErrorState extends ShopStates {
  final String error;
  ShopGetSearchErrorState(this.error);
}
