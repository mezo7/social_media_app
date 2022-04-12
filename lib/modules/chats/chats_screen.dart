import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model/user_model.dart';
import '../../modules/chats/chat_details_screen.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => myDivaider(context),
              itemCount: SocialCubit.get(context).users.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model ,context) => InkWell(
    onTap: (){
      navigateTo(context,ChatDetailsScreen(model));
    },
    child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  '${model.image}'),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ]),
        ),
  );
}
