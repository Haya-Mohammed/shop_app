import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/modules/search/cubit/cubit.dart';
import 'package:shop_app1/modules/search/cubit/states.dart';
import 'package:shop_app1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: [
                  defaultFormField(
                      label: 'Search',
                      prefix: Icons.search,
                      controller: searchController,
                      validate: (String? value) {
                        if (value == null) {
                          return 'please enter a product to search it';
                        }
                        return null;
                      },
                      onSubmit: (String? value) {
                        ShopSearchCubit.get(context)
                            .getSearch(text: value.toString());
                      }),
                  if (state is ShopSearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildProductsList(
                          ShopSearchCubit.get(context)
                              .searchModel!
                              .data
                              .data[index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: ShopSearchCubit.get(context)
                            .searchModel!
                            .data
                            .data
                            .length,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
