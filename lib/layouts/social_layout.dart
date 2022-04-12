import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/new_post/new_post_screen.dart';
import '../modules/search/search_screen.dart';
import '../shared/component/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if(state is NewPostState){
            navigateTo(context, NewPostScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                IconButton(onPressed: (){}, icon:Icon( IconBroken.Notification,)),
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon:Icon( IconBroken.Search,)),
                SizedBox(width: 10.0,),
              ],
            ),
            body:cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Chat,
                    ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Upload,
                    ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Location,
                    ),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Profile,
                    ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        });
  }
}
