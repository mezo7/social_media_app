import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/login/login_screen.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/component/components.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> RegisterCubit(),
      child:BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is CreateSuccessState){
            showShortToast(text: 'Register Successfully', state: ToastStates.SUCCESS);
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'Register Now To Communicate With Friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtTextFormField(
                          context: context,
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          label: 'Name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              // LoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context).changePassVisi();
                            },
                            icon: Icon(
                              RegisterCubit.get(context).suffix,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          context: context,
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                          },
                          label: 'Phone Number'
                              '',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'REGISTER',
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
