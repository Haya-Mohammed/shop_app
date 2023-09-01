import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/layout/home_screen.dart';
import 'package:shop_app1/modules/register/cubit/cubit.dart';
import 'package:shop_app1/modules/register/cubit/states.dart';
import 'package:shop_app1/network/local/cache_helper.dart';
import 'package:shop_app1/shared/components/components.dart';
import 'package:shop_app1/shared/constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.data!.token)
                .then((value) {
              token = state.registerModel.data!.token;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            });
          } else {
            showToast(
              msg: state.registerModel.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 50),
                      defaultFormField(
                        label: 'Username',
                        prefix: Icons.person,
                        controller: usernameController,
                        onChange: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Username must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      defaultFormField(
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                        controller: emailController,
                        onChange: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email address must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      defaultFormField(
                        label: 'Phone',
                        prefix: Icons.phone,
                        controller: phoneController,
                        onChange: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      defaultFormField(
                        label: 'Password',
                        prefix: Icons.lock,
                        controller: passwordController,
                        suffix:
                            isPassword ? Icons.visibility : Icons.visibility_off,
                        isPassword: isPassword,
                        onChange: null,
                        onSuffixPress: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                name: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          isUpperCase: true,
                          radius: 10,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
