import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uiam_business/app/data/models/business_model.dart';
import 'package:uiam_business/app/data/providers/business_provider.dart';
import 'package:uiam_business/app/data/providers/person_provider.dart';

import '../data/models/person_model.dart';
import '../routes/app_pages.dart';

class AuthService extends GetxService {
  final _firebaseAuth = FirebaseAuth.instance;

  final Rxn<User> _firebaseUser = Rxn<User>(FirebaseAuth.instance.currentUser);
  final isLoaded = false.obs;

  // TODO: implement User Model
  BusinessModel user = BusinessModel();

  User? get firebaseUser => _firebaseUser.value;

  bool get isAuth => firebaseUser != null;
  String get uid => firebaseUser!.uid;

  @override
  void onInit() {
    ever(_firebaseUser, _onAuthChanges);

    _firebaseUser.bindStream(_firebaseAuth.userChanges());
  }

  void _onAuthChanges(User? firebaseUser) async {
    // TODO: implement User Model
    if (isAuth) {
      if (user.id == null) {
        user = await BusinessProvider(uid).fetch();
        print(user);
      }
    } else {
      user = BusinessModel();
    }
    if (Get.currentRoute != Routes.SPLASH) {
      redirect();
    }
  }

  redirect() {
    if (firebaseUser == null) {
      if (Get.currentRoute != Routes.LOGIN) Get.offAllNamed(Routes.LOGIN);
    } else {
      if (Get.currentRoute != Routes.HOME) Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
