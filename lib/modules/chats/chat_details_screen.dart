import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model/message_model.dart';
import '../../models/user_model/user_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel ?userModel;

  ChatDetailsScreen(this.userModel);
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){
            if(state is SendMessagesSuccessState){
              messageController.text = '';
            }
          },
          builder: (context,state){
            return  ConditionalBuilder(
              condition: SocialCubit.get(context).messages.length>0,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                      SizedBox(width: 15,),
                      Text('${userModel!.name}'),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              var message = SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel!.uId ==message.senderId)
                                return buildSenderMessages(message,context);
                              return buildReceiverMessages(message,context);
                            },
                            separatorBuilder: (context,index) => SizedBox(height: 10,),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          //borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message...',
                                  hintStyle:Theme.of(context).textTheme.caption!.copyWith(
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                                controller: messageController,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                //borderRadius: BorderRadius.circular(15.0),
                              ),
                              height: 50,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );

                                },
                                minWidth: 1.0,
                                child: Icon(IconBroken.Send,size: 18,color: Colors.white,),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverMessages (MessageModel model ,context) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5,),
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      child: Text('${model.text}'),
    ),
  );
  Widget buildSenderMessages(MessageModel model , context) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor.withOpacity(0.5,),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      child: Text('${model.text}'),
    ),
  );
}
