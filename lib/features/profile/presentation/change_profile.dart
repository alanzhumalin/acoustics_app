import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeName> {
  final TextEditingController _nameController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ваши данные',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Напишите корректно';
                    }
                    return null;
                  },
                  cursorErrorColor: Colors.blue,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    hintText: 'Новое имя',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.2,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Подтвердить',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
