import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post_model/post_model.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is CommentPostSuccessState){
          commentController.text = '';
        }
      },
      builder: (context,state){
        return  ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length>0,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(5.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/close-up-young-attractive-charismatic-woman-isolated_273609-35522.jpg?w=740'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Text(
                        'Communicate With Friends',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index,),
                  separatorBuilder: (context,index)=> myDivaider(context),
                  itemCount: SocialCubit.get(context).posts.length,

                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
    }
    );
  }

  Widget buildPostItem(PostModel model ,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    color: Theme.of(context).backgroundColor,
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified,
                          color: defualtColor,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${model.dateTime}',
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
              ),
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).primaryColorLight,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 10.0,),

          // Padding(
          //   padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               padding: EdgeInsets.zero,
          //               minWidth: 1.0,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(
          //                   color: defualtColor,
          //                   fontSize: 13.0,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               padding: EdgeInsets.zero,
          //               minWidth: 1.0,
          //               child: Text(
          //                 '#flutter',
          //                 style: TextStyle(
          //                   color: defualtColor,
          //                   fontSize: 13,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                image: NetworkImage(
                    '${model.postImage}'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likesCount[index]}',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Likes',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16,
                            color: Colors.deepOrangeAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).commentsCount[index]}',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Comment',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context).postLike(SocialCubit.get(context).likePostId[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Send,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Comment',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context).postComment(postId: SocialCubit.get(context).commentPostId[index], textComment:commentController.text);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).userModel!.image}',
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        hintText: 'write a comment',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],),
            ],
          ),
        ],
      ),
    ),
  );
}
