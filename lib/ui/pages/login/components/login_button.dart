import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<dynamic>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return ElevatedButton(
              onPressed: snapshot.data == true ? presenter.auth : null,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor
              ),
              child: Text('Entrar'.toUpperCase())
          );
        }
    );
  }
}