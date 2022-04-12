
import 'dart:io';

import 'package:applecation/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/post_model/post_model.dart';
import '../../models/user_model/message_model.dart';
import '../../models/user_model/user_model.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../modules/settings/profile_screen.dart';
import '../../modules/users/users_screen.dart';
import '../component/components.dart';
import '../component/constance.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;

  void changePassVisi() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_rounded;
    emit(ChangePasswordVisiState());
  }
} //Login Cubit Finsh

// Register Cubit Start

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,


      );
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
}){
    UserModel userModel = UserModel(
        name : name,
        email:email,
        phone:phone,
        uId:uId,
        image: 'https://img.freepik.com/free-photo/portrait-happy-young-man_171337-21716.jpg?w=740',
      cover: 'https://img.freepik.com/free-photo/man-using-digital-tablet-psd-mockup-smart-technology_53876-110815.jpg?t=st=1648790814~exp=1648791414~hmac=020c35ebbb0e81fd377625820311e2f20f05c5089fa1e51d92357b801ae1ac3c&w=740',
      bio: 'Write Your Bio ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {
      emit(CreateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;

  void changePassVisi() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_rounded;
    emit(ChangePasswordVisibilityState());
  }
} //Register Cubit Finsh


class SocialCubit extends Cubit<SocialStates>{


  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserData(){
    emit(GetUserLoadingState());
    emit(UpdateUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
      userModel = UserModel.fromJson(value.data()!);
     // print(value.data());
      emit(GetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens=[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<String>titles=[
    'Home',
    'Chats',
    'Post',
    'Users',
    'Profile',
  ];
  void changeBottomNav(int index) {
    if(index==0){
      //getPosts();
    }
    if(index==1)
      getAllUsers();
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

     File?  profileImage;
    var picker = ImagePicker();
  Future<void>getProfileImage()async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
     if(pickedFile != null){
      profileImage = File(pickedFile.path);
       emit(ProfileImagePickedSuccessState());
     }else {
       emit(ProfileImagePickedErrorState());
       showShortToast(text: 'No Image Selected', state: ToastStates.WARNING);
     }
    }


  void uploadProfileImage({
  required String name,
  required String phone,
  required String bio,}){
    emit(UpdateUserLoadingState());
      firebase_storage.FirebaseStorage.instance
        .ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
            value.ref.getDownloadURL().then((value) {
              updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error){
        emit(UploadProfileImageErrorState());
        print(error.toString());
      });
    }).catchError((error){
      emit(UploadProfileImageErrorState());
      print(error.toString());
    });

  }


  File ? coverImage;
  var coverPicker = ImagePicker();
  Future<void>getCoverImage()async
  {
    final pickedFile1 = await coverPicker.getImage(source: ImageSource.gallery);
    if(pickedFile1 != null){
      coverImage = File(pickedFile1.path);
      emit(CoverImagePickedSuccessState());
    }else {
      emit(CoverImagePickedErrorState());
      showShortToast(text: 'No Image Selected', state: ToastStates.WARNING);
    }
  }


  void uploadCoverImage({
  required String name,
  required String phone,
  required String bio,})
  {
    emit(UpdateUserLoadingState());
      firebase_storage.FirebaseStorage.instance
        .ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {

        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
        emit(UploadCoverImageErrorState());
        print(error.toString());
      });
    }).catchError((error){
      emit(UploadCoverImageErrorState());
      print(error.toString());
    });

  }


//   void updateProfileImages({
//   required String name,
//   required String phone,
//   required String bio,
// }){
//     if(coverImage != null){
//       uploadCoverImage();
//     }
//     else if(profileImage!=null){
//       uploadProfileImage();
//     }
//     else if(coverImage != null && profileImage!=null){
//
//     }
//     else{
//       updateUser(name: name, phone: phone, bio: bio,);
//
//     }
//
//
//   }
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover ,
    String? image,
  }){
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      name : name,
      phone:phone,
      bio : bio,
      email: userModel!.email,
      cover: cover??userModel!.cover,
      image: image??userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      //showShortToast(text: 'Updating Successfully', state: ToastStates.SUCCESS);
      getUserData();
    }).catchError((error){
      emit(UpdateUserErrorState());
      print(error.toString());
    });

  }


  File?  postImage;
  var postPicker = ImagePicker();
  Future<void>getPostImage()async
  {
    final pickedFile = await postPicker.getImage(source: ImageSource.gallery);
    if(pickedFile != null){
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    }else {
      emit(PostImagePickedErrorState());
      showShortToast(text: 'No Image Selected', state: ToastStates.WARNING);
    }
  }

  void removePostImage(){
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
    required context,
}){
    emit(UploadPostImageLoadingState());
     firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value) {
                print(value);
                createPost(context:context,dateTime: dateTime, text: text,postImage: value);
          }).then((value) {
            Navigator.pop(context);
          })
              .catchError((error){
                emit(CreatePostErrorState());
          });
    })
        .catchError((error){
          emit(CreatePostErrorState());
    });

  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
    required context,
  }){
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name : userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error){
      emit(CreatePostErrorState());
      print(error.toString());
    });

  }

  List<PostModel> posts = [];
  List<String> likePostId =[];
  List<String> commentPostId =[];
  List<int> likesCount =[];
  List<int> commentsCount = [];
  PostModel? postModel;
  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference.collection('likes').get().then((value)
            {
              likesCount.add(value.docs.length);
              posts.add(PostModel.fromJson(element.data()));
              likePostId.add(element.id);
            }).catchError((error) {
              print(error);
            });
          });
          value.docs.forEach((element) {
            element.reference.collection('comments').get().then((value) {
              commentsCount.add(value.docs.length);
              commentPostId.add(element.id);
            }).catchError((error){
              print(error.toString());
            });
          });
          emit(GetPostsSuccessState());
    }).catchError((error){
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void postLike(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LikePostErrorState(error.toString()));
    });
  }

  void postComment({required String textComment,required String postId}){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment':textComment,
    }).then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CommentPostErrorState(error.toString()));
    });
  }


  List<UserModel> users = [];
  void getAllUsers(){
    if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.data()['uId'] != userModel!.uId)
            users.add(UserModel.fromJson(element.data()));
          });
          emit(GetPostsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetPostsErrorState(error.toString()));
    });

  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
}){
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap(),)
        .then((value) {
          emit(SendMessagesSuccessState());
    })
        .catchError((error){
          print(error);
          emit(SendMessagesErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap(),)
        .then((value) {
      emit(SendMessagesSuccessState());
    })
        .catchError((error){
      print(error);
      emit(SendMessagesErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessages ({required String receiverId}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dateTime')
        .snapshots().listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessagesSuccessState());
    });
  }


}
