import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/models/favorites_model.dart';
import 'package:shop_app1/shared/components/components.dart';
import 'package:shop_app1/shared/cubit/cubit.dart';
import 'package:shop_app1/shared/cubit/states.dart';
import 'package:shop_app1/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildProductsList(
                ShopCubit.get(context).favoritesModel?.data.data[index].product,
                context),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: ShopCubit.get(context).favorites.length,
            physics: const BouncingScrollPhysics(),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
