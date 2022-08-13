import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/domain/bloc/cubit/app_cubit.dart';
import 'package:tracking/domain/bloc/states/app_states.dart';
import 'package:tracking/presentation/custom_widgets/custom_app_bar.dart';
import 'package:tracking/presentation/custom_widgets/default_button.dart';
import 'package:tracking/presentation/custom_widgets/login_text_field.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/res/assets_manager.dart';
import 'package:tracking/presentation/screens/home_screen.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppbar(title: 'Admin Login'),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.naqlXLogo,
                    width: deviceWidth * .4,
                  ),
                  const SizedBox(height: 40),
                  CustomLoginTextField(
                    controller: cubit.emailController,
                    hit: 'Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomLoginTextField(
                    controller: cubit.passwordController,
                    hit: 'Password',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocListener<AppCubit, AppStates>(
                    listener: (context, state) {
                      if(state is LoginSuccessState){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=> HomeScreen(isDriver: false,)));
                      }else if(state is LoginErrorState){
                        // handle error in ui
                      }
                    },
                    child: DefaultButton(
                      onTap: () {
                        //send driver 'name', 'phone', 'latitude', 'longitude' -> to firebase
                        if(formKey.currentState!.validate()){
                          cubit.adminLogin();
                        }
                      },
                      title: 'Login',
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
