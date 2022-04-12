import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context,state){
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar:AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 0.0,
            title: Text('Create Post'),
            actions: [
              TextButton(
                child: Text(
                  'Post'.toUpperCase(),
                  style: TextStyle(
                    color: defualtColor,
                  ),
                ),
                onPressed: () {
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null) {
                    if(textController.text == ''||textController.text == ' '){
                      showShortToast(text: 'Please Write Post ..! *_*', state: ToastStates.WARNING);
                    }else{
                      SocialCubit.get(context).createPost(
                        context: context,
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                  }else{
                    SocialCubit.get(context).uploadPostImage(
                      context: context,
                        dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 15,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userModel.name}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            height: 1.0,
                            color:
                            Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'What is in your mind...',
                        border: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize:14,
                        ),


                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                if(state is UploadPostImageLoadingState)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10,),
                  child: LinearProgressIndicator(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image,size: 24,),
                              SizedBox(width: 5,),
                              Text('Add Photo',style: TextStyle(fontSize: 18,),),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('#',style: TextStyle(fontSize: 20),),
                            SizedBox(width: 5,),
                            Text('Tags',style: TextStyle(fontSize: 18,),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
