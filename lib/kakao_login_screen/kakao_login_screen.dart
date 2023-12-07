import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project2/kakao_login_screen/kakao_login.dart';
import 'package:final_project2/kakao_login_screen/main_view_model.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:final_project2/screens/home_screen/home_screen.dart'; // Import the HomeScreen class

class KakaologinScreen extends StatefulWidget {
  const KakaologinScreen({Key? key, this.title = "Default Title"}) : super(key: key);
  static String routeName = 'KakaologinScreen';
  final String title;

  @override
  State<KakaologinScreen> createState() => _KakaologinScreenState();
}

class _KakaologinScreenState extends State<KakaologinScreen> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ElevatedButton(
                onPressed: () async {
                  await viewModel.login();
                  setState(() {});
                },
                child: const Text('Login'),
              );
            }

            // Check if Kakao login is successful
            if (viewModel.isLogined) {
              // Navigate to the HomeScreen
              Navigator.pushNamed(context, HomeScreen.routeName);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? '',
                ),
                Text(
                  '${viewModel.isLogined}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.logout();
                    setState(() {});
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
