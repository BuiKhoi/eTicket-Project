import 'dart:convert';

import 'package:flutter/material.dart';
import 'authentication.dart';
import 'dashboard.dart';
import 'package:http/http.dart';
import 'hooman.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(this.auth, this.onSignedIn);

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State createState() {
    return new _loginScreenState();
  }
}

enum FormMode {
  LOGIN,
  SIGNUP
}

int point = 0;
List<RankedHooman> ranked_list;

class _loginScreenState extends State<LoginScreen> {

  bool _isLoading = false;
  String _email;
  String _password;
  FormMode _formMode = FormMode.LOGIN;
  String _errorMessage = "";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showBody() {
    return new Container(
      padding: EdgeInsets.all(16),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            _showErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(height: 0.0, width: 0.0,);
  }

  Widget _showLogo() {
    return new Hero(
        tag: 'Hero',
        child: Padding(
          padding: EdgeInsets.fromLTRB(_getCenterPadding(), 80, _getCenterPadding(), 0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48,
            child: Image.asset('assets/logo1.png'),
          ),
        )
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )
        ),
        validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )
        ),
        validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(75.0, 50.0, 60.0, 0.0),
      child: new MaterialButton(
        elevation: 5.0,
        minWidth: 200.0,
        height: 42,
        color: Colors.green[500],
        child: _formMode == FormMode.LOGIN ? new Text(
            'Login',
            style: new TextStyle(
                fontSize: 20.0, color: Colors.white
            )
        ) : new Text(
          'Create account',
          style: new TextStyle(
              fontSize: 20.0, color: Colors.white
          ),
        ),
        onPressed: _validateAndSubmit,

      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN ?
      new Text(
        'Create an account',
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ) : new Text(
        'Have an account? Sign in',
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignup : _changeFormToSignin,
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  void _changeFormToSignup() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToSignin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  void _validateAndSubmit() async {
    //print('Hooman just pressed login');
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (true){
      String userId = "";

      //_formKey.currentState.validate();
      //_formKey.currentState.save();
      _email = "khoibui2319@gmail.com";
      _password = "123123123";

      try {
        if (_formMode == FormMode.LOGIN) {
          print("Logging in");
          userId = await widget.auth.signIn(_email, _password);
        } else {
          print("Signing up");
          userId = await widget.auth.signUp(_email, _password);

          String url = "https://us-central1-devfest-2019-255504.cloudfunctions.net/addUser?id=" + userId;
          get(url);
        }
        if (userId != null && userId.length >0) {
          //print("Logged in with id: $userId");
          setState(() {
            _isLoading = false;
            _errorMessage = "";
          });
          //widget.onSignedIn();
          var hooman = new Hooman(userId);
          hooman.getPoints().then((value) {
            hooman.points = value;
            point = value;
            getRanked().then((list) {
              ranked_list = list;
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => new Dashboard(hooman,)));
            });
          });
        }
      } catch (e) {
        print("Error caught: $e");
        setState(() {
          _isLoading = false;
          _errorMessage = "Cannot sign in, please try again, more info: " + e.toString();
        });
      }
    }
  }

  double _getCenterPadding() {
    double width = MediaQuery.of(context).size.width;
    width -= 148/2;
    width /= 2;
    return width - 10;
  }

  Future<List<RankedHooman>> getRanked() async {
    List<RankedHooman> list = new List<RankedHooman>();
    var jsonString = await get("https://us-central1-devfest-2019-255504.cloudfunctions.net/getRanking");
    final jsonReponse = json.decode(jsonString.body);
    for (var res in jsonReponse) {
      var rhooman = new RankedHooman(res["Name"], res["Points"], res["Image"]);
      list.add(rhooman);
    }
    return list;
  }
}