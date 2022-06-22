import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context){

          widget.presenter.isLoadingStream.listen((isLoading) {
              if(isLoading){
                  showLoading(context);
              } else {
                  hideLoading(context);
              }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if(error != null){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Colors.red.shade900,
                      content: Text(error, textAlign: TextAlign.center),
                  )
              );
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1(text: 'Login'),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<dynamic>(
                            stream: widget.presenter.emailErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                                    errorText: snapshot.data == '' ? null : snapshot.data
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: widget.presenter.validateEmail,
                              );
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<dynamic>(
                              stream: widget.presenter.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Senha",
                                      icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                                      errorText: snapshot.data == '' ? null : snapshot.data
                                  ),
                                  obscureText: true,
                                  onChanged: widget.presenter.validatePassword,
                                );
                              }
                          ),
                        ),
                        StreamBuilder<dynamic>(
                            stream: widget.presenter.isFormValidStream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                  onPressed: snapshot.data == true ? widget.presenter.auth : null,
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor
                                  ),
                                  child: Text('Entrar'.toUpperCase())
                              );
                            }
                        ),
                        TextButton.icon(
                            onPressed: (){},
                            icon: Icon(Icons.person),
                            label: Text('Criar Conta')
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}




