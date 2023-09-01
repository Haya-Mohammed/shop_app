import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/shared/components/components.dart';
import 'package:shop_app1/shared/cubit/cubit.dart';
import 'package:shop_app1/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null,
        builder: (context) {
           var model = ShopCubit.get(context).userModel!;

          usernameController.text = model.data!.name;
          emailController.text = model.data!.email;
          phoneController.text = model.data!.phone;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20),
                  defaultFormField(
                    label: 'User Name',
                    prefix: Icons.person_outlined,
                    controller: usernameController,
                    validate: (String? value) {
                      if (value == null) {
                        return 'Username cann\'t be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    label: 'Email',
                    prefix: Icons.email_outlined,
                    controller: emailController,
                    validate: (String? value) {
                      if (value == null) {
                        return 'Email cann\'t be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    label: 'Phone',
                    prefix: Icons.phone_outlined,
                    controller: phoneController,
                    validate: (String? value) {
                      if (value == null) {
                        return 'Phone cann\'t be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'Sign Out',
                  ),
                  const SizedBox(height: 20),
                  defaultButton(
                    function: () {
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(
                          name: usernameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'Update',
                  ),
                ],
              ),
            ),
          );
        },
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
