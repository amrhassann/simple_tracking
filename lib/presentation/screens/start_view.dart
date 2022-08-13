import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking/domain/bloc/cubit/app_cubit.dart';
import 'package:tracking/presentation/res/app_colors.dart';
import 'package:tracking/presentation/screens/choose_user_type.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child:  MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.initial,
        ),
        debugShowCheckedModeBanner: false,
        home: const ChooseUserType(),
      ),
    );
  }
}