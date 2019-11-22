import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerlogin/constants.dart';
import 'package:providerlogin/login_page.dart';
import 'package:providerlogin/model/user_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();

            case Status.Unauthenticated:
              return LoginPage();

            case Status.Authenticating:
              return LoginPage();

            case Status.Authenticated:
              return UserInfoPage(user: user.user);
          }
        },
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final FirebaseUser user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () => Provider.of<UserRepository>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
              Card(
                child: Image.asset('assets/images/logo.png', width: 200.00, height: 200.00,),
                 
              ),
              Text(appName),
        ]



      )
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        
        child: Text(appName),
      ),
    );
  }
}
