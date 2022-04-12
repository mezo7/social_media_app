
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layouts/social_layout.dart';
import '../../modules/register/register_screen.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginErrorState){
            showShortToast(text: 'Wrong Email or Password', state: ToastStates.ERROR);
          }
          if(state is LoginSuccessState){
            CacheHelper.saveData(key:  'uId', value:state.uId).then((value) {
              showShortToast(text: 'Login Successfully', state: ToastStates.SUCCESS);
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          Text(
                            'Login Now To Communicate With Friends',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          const SizedBox(
                            height: 30.0,
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
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              onPressed: () {
                                LoginCubit.get(context).changePassVisi();
                              },
                              icon: Icon(
                                LoginCubit.get(context).suffix,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            suffixPressed: () {},
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Center(
                            child: defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t Have An Account? || ',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    RegisterScreen(),
                                  );
                                },
                                child: Text(
                                  'Register Now'.toUpperCase(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
