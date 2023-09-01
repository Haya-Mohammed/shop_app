import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/layout/home_screen.dart';
import 'package:shop_app1/modules/login/login_screen.dart';
import 'package:shop_app1/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app1/network/local/cache_helper.dart';
import 'package:shop_app1/network/remote/dio_helper.dart';
import 'package:shop_app1/shared/bloc_observer.dart';
import 'package:shop_app1/shared/constants/constants.dart';
import 'package:shop_app1/shared/cubit/cubit.dart';
import 'package:shop_app1/shared/cubit/states.dart';
import 'package:shop_app1/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onboarding = CacheHelper.getData(key: 'onboarding');
  token = CacheHelper.getData(key: 'token');
  print('token = $token');

  Widget startWidget(){
    if(onboarding != null){
      if(token != null){
        return const HomePage();
      }
      return LoginScreen();
    }
    else{
      return const OnBoardingScreen();
    }
  }

  runApp(MyApp(isDark, startWidget()));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget widget;

  const MyApp(this.isDark, this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
          ShopCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
