

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? uId = '';
void signOut(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}
// if (!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.deepOrangeAccent.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.all(5.0),
// child: Container(
// height: 50,
// child: Row(
// children: [
// const Icon(Icons.info_outline),
// const SizedBox(
// width: 5,
// ),
// const Expanded(
// child: Text(
// '  Please Verify Your Email',
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: 12,
// ),
// ),
// ),
// const SizedBox(
// width: 10.0,
// ),
// defualtButton(
// function: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showShortToast(text: 'Check Your Mail', state: ToastStates.SUCCESS);
// })
//     .catchError((error) {
// print(error.toString());
// });
// },
// text: 'Send Email Verification',
// width: 195,
// )
// ],
// ),
// ),
// ),
// ),