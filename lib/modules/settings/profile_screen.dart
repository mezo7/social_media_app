import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constance.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';
import 'edit_profile_screen.dart';


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0,),
                            topRight: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                            '${userModel.image}',
                          ),
                        ),
                      radius: 62.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text('${userModel.name}',
              style:Theme.of(context).textTheme.bodyText1,
              ),
              Text('${userModel.bio}',
              style:Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Posts',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '250',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Photos',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followers',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followings',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        onPressed: () {  },
                        child: Text(
                          'Add Photo',
                        style:TextStyle(
                           color: Theme.of(context).highlightColor,
                        ),
                        ),
                      ),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: (){
                    navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(IconBroken.Edit,size: 16,),)
                ],
              ),
              defualtButton(
                text: 'Sign Out',
                function: (){
                  signOut(context);
                },
                background: Colors.red,
              ),

            ],
          ),
        ),
      );
      },
    );
  }
}
