import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';

dynamic createAuthMiddleware(context) {
  final logIn = _createLogInMiddleware(context);
  final logOut = _createLogOutMiddleware();
  return [
    new TypedMiddleware<AppState, LogIn>(logIn),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ];
}

Middleware<AppState> _createLogInMiddleware(context) {
  return (Store store, action, NextDispatcher next) async {
    User user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    if (action is LogIn) {
      try {
        //GoogleSignInAccount googleUser = await (_googleSignIn.signIn() as FutureOr<GoogleSignInAccount>);
        GoogleSignInAccount googleUser =
            await (_googleSignIn.signIn() as GoogleSignInAccount);
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        User user = authResult.user;
        print("signed in " + user.displayName);

        /*user = await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );*/
        print('Logged in ${user.displayName}');
        store.dispatch(new LogInSuccessful(user: user));
      } catch (error) {
        store.dispatch(new LogInFail(error));
      }
    }
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (action is LogOut) {
      try {
        await _auth.signOut();
        print('logging out...');
        store.dispatch(new LogOutSuccessful());
      } catch (error) {
        print(error);
      }
    }
  };
}
