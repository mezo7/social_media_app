import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        emailController.text = userModel.email!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 0.0,
            title: Text('Edit Profile'),
            actions: [
              TextButton(
                child: Text(
                  'Update'.toUpperCase(),
                  style: TextStyle(
                    color: defualtColor,
                  ),
                ),
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateUserLoadingState)
                      LinearProgressIndicator(),
                    if (state is UpdateUserLoadingState)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      height: 200.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        4.0,
                                      ),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                                radius: 62.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: defualtColor,
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      'Upload Image',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                          if (SocialCubit.get(context).profileImage != null)
                            SizedBox(
                              width: 5,
                            ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    margin: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: defualtColor,
                                    ),
                                    child: TextButton(
                                      child: Text(
                                        'Upload Cover',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                    ),
                                  ),

                                  // SizedBox(height: 2,),
                                  // LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      SizedBox(
                        height: 20.0,
                      ),
                    defualtTextFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.toString().isEmpty)
                          return 'Name Must Not Be Empty';
                      },
                      label: 'Name',
                      prefixIcon: IconBroken.Profile,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defualtTextFormField(
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      isClicked: false,
                      validate: (value) {},
                      label: 'Email Address',
                      prefixIcon: IconBroken.Message,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defualtTextFormField(
                      context: context,
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.toString().isEmpty) return value = ' ';
                      },
                      label: 'Bio',
                      prefixIcon: IconBroken.More_Square,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defualtTextFormField(
                      context: context,
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.toString().isEmpty)
                          return 'Phone Must Not Be Empty';
                      },
                      label: 'Phone',
                      prefixIcon: IconBroken.Calling,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
