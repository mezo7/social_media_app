import 'package:applecation/shared/cubit/cubit.dart';
import 'package:applecation/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'layouts/social_layout.dart';
import 'modules/login/login_screen.dart';
import 'shared/component/components.dart';
import 'shared/component/constance.dart';
import 'shared/network/local/cache_helper.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  showShortToast(text: 'Handling a background message', state: ToastStates.SUCCESS);
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    showShortToast(text: 'Handling a on message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showShortToast(text: 'Handling a open app message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = SocialLayout();
  }else{
    widget = LoginScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: startWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

