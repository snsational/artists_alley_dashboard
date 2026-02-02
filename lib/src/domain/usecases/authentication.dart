import 'package:artists_alley_dashboard/src/domain/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationUsecase implements AuthenticationRepository {
  @override
  Future<UserCredential> signInWithGoogle() async {
    final auth = FirebaseAuth.instance;
    final provider = GoogleAuthProvider();

    // Optional: request additional scopes
    // provider.addScope('https://www.googleapis.com/auth/contacts.readonly');

    // Optional: force account selection
    provider.setCustomParameters({'prompt': 'select_account'});

    return await auth.signInWithPopup(provider);
  }
}
