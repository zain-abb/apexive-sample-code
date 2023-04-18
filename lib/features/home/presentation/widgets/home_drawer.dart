import 'package:flutter/material.dart';

import '../../data/models/user/local_user.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key, required this.user}) : super(key: key);
  final LocalUser user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                user.image,
              ),
            ),
            accountName: Text(user.firstName),
            accountEmail: Text(user.email),
          )
        ],
      ),
    );
  }
}
