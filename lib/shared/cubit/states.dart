abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisiState extends LoginStates {}

// Register States

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}class CreateSuccessState extends RegisterStates {}

class CreateErrorState extends RegisterStates {
  final String error;
  CreateErrorState(this.error);
}
class ChangePasswordVisibilityState extends RegisterStates {}


// Main Cubit

abstract class SocialStates{}
class InitialState extends SocialStates{}
class GetUserLoadingState extends SocialStates{}
class GetUserSuccessState extends SocialStates{}
class GetUserErrorState extends SocialStates{
  final String error;
  GetUserErrorState(this.error);
}
class UpdateUserLoadingState extends SocialStates{}
class UpdateUserErrorState extends SocialStates{}

class ProfileImagePickedSuccessState extends SocialStates{}
class ProfileImagePickedErrorState extends SocialStates{}


class UploadProfileImageSuccessState extends SocialStates{}
class UploadProfileImageErrorState extends SocialStates{}


class CoverImagePickedSuccessState extends SocialStates{}
class CoverImagePickedErrorState extends SocialStates{}

class UploadCoverImageSuccessState extends SocialStates{}
class UploadCoverImageErrorState extends SocialStates{}


class ChangeBottomNavState extends SocialStates{}
class NewPostState extends SocialStates{}


class PostImagePickedSuccessState extends SocialStates{}
class PostImagePickedErrorState extends SocialStates{}
class RemovePostImageState extends SocialStates{}
class UploadPostImageLoadingState extends SocialStates{}


class CreatePostLoadingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class CreatePostErrorState extends SocialStates{}


class GetPostsLoadingState extends SocialStates{}
class GetPostsSuccessState extends SocialStates{}
class GetPostsErrorState extends SocialStates{
  final String error;
  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends SocialStates{}
class LikePostErrorState extends SocialStates{
  final String error;
  LikePostErrorState(this.error);
}

class CommentPostSuccessState extends SocialStates{}
class CommentPostErrorState extends SocialStates{
  final String error;
  CommentPostErrorState(this.error);
}

class GetAllUserLoadingState extends SocialStates{}
class GetAllUserSuccessState extends SocialStates{}
class GetAllUserErrorState extends SocialStates{
  final String error;
  GetAllUserErrorState(this.error);
}


class SendMessagesSuccessState extends SocialStates{}
class SendMessagesErrorState extends SocialStates{}
class GetMessagesSuccessState extends SocialStates{}
class GetMessagesErrorState extends SocialStates{}




