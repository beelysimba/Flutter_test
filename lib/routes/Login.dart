import 'package:flutter/material.dart';
import 'package:testapp/index.dart';
import '../index.dart';


class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _nameController.text = Global.profile.lastLogin;
    if (_nameController.text != null && _nameController.text.length>1) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(gm.login)),
      body: Padding(padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: gm.userName,
                  hintText: gm.userName,
                  prefixIcon: Icon(Icons.person),
                  ),
                validator: (v) {
                  return v.trim().isNotEmpty?null:gm.userNameRequired;
                },
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(icon: Icon(pwdShow?Icons.visibility_off:Icons.visibility), 
                    onPressed: (){
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    }),
                  ),
                obscureText: !pwdShow,
                validator: (v) {
                  return v.trim().isNotEmpty?null:gm.passwordRequired;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 25),
              child: ConstrainedBox(constraints: BoxConstraints.expand(height:55.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(gm.login),
                onPressed: _onlogin),),
              ),
            ],
          ),
          ),
      ),
    );
  }

  void _onlogin() async {
        // 提交前，先验证各个表单字段是否合法
  if ((_formKey.currentState as FormState).validate()) {
    showLoading(context);
    User user;
    try {
      user = await Git(context).login(_nameController.text, _pwdController.text);
      Provider.of<UserModel>(context, listen: false).user = user;
    } catch (e) {
      // if (e.response?.statusCode == 401) {
        showToast(e.toString());
      // }
    } finally {
      Navigator.of(context).pop();
    }
    if (user != null) {
      Navigator.of(context).pop();
    }

  }

}
}

