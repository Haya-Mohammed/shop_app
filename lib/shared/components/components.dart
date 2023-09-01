import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/modules/login/login_screen.dart';
import 'package:shop_app1/network/local/cache_helper.dart';
import 'package:shop_app1/shared/cubit/cubit.dart';

import '../styles/colors.dart';

Widget defaultButton({
  required Function() function,
  required String text,
  double width = double.infinity,
  Color background = Colors.red,
  bool isUpperCase = true,
  double radius = 15,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(color: Colors.white)),
      ),
    );

Widget defaultFormField({
  required String label,
  required IconData prefix,
  IconData? suffix = null,
  TextInputType inputType = TextInputType.emailAddress,
  required TextEditingController controller,
  required String? Function(String?) validate,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function()? onSuffixPress,
  bool isPassword = false,
}) =>
    TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix == null
            ? null
            : IconButton(
                onPressed: onSuffixPress,
                icon: Icon(suffix),
              ),
      ),
      keyboardType: inputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      controller: controller,
      obscureText: isPassword ? true : false,
    );

Future<bool?> showToast({
  required String msg,
  required ToastStates state,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context) {
  TextButton(
    onPressed: () {
      CacheHelper.removeData(key: 'token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    },
    child: const Text('LOGOUT'),
  );
}

Widget buildProductsList(model, context, {isOldPrice = true}) {
  return Container(
    padding: const EdgeInsets.all(20),
    color: Colors.white,
    height: 150,
    width: double.infinity,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image ?? 'https://png.pngtree.com/png-clipart/20190520/original/pngtree-question-mark-vector-icon-png-image_3722522.jpg'),
              height: 100,
            ),
            if (model.discount != 0 && isOldPrice == true)
              Container(
                color: defaultColor,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${model.price}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                  ),
                ),
                const SizedBox(width: 20),
                if (model.discount != 0  && isOldPrice == true)
                  Text(
                    '${model.oldPrice}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                    ShopCubit.get(context).favorites[model.id]!
                        ? defaultColor
                        : Colors.grey,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
