import 'package:acousticsapp/features/auth/presentation/login.dart';
import 'package:acousticsapp/features/profile/presentation/change_profile.dart';
import 'package:acousticsapp/features/profile/presentation/my_ads.dart';
import 'package:acousticsapp/features/profile/presentation/politics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Профиль',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/porshe.jpg'),
            radius: size.height * 0.08,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Привет, Alan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyAds()));
            },
            title: Text(
              'Ваши объявления',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeProfile()));
            },
            title: Text(
              'Изменить данные',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Politics()));
            },
            title: Text(
              'Политика конфиденциальности',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text(
              'Выйти',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final des = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    content: Text(
                      'Вы уверены?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Да',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Нет',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                },
              );

              if (des == true) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
