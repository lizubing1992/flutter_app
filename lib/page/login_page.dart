import 'package:flutter/material.dart';
import '../model/user_info.dart';
import '../util/data_util.dart';
import '../manager/bus_manager.dart';
import '../event/update_user_info_event.dart';
import '../manager/user_manager.dart';
import '../constant/strings.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _account = '';
  String _password = '';
  bool _isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = new GlobalKey();

  void _login(BuildContext context) async {
    //关闭键盘
    FocusScope.of(context).requestFocus(new FocusNode());
    FormState form = _formKey.currentState;

    if (form.validate()) {
      //保存表单
      form.save();
      //显示loading
      setState(() {
        _isLoading = true;
      });

      //获取用户数据
      UserInfo userInfo = await DataUtil.login(this._account, this._password);

      setState(() {
        _isLoading = false;
      });

      if (userInfo != null) {
        await UserManager.saveToLocal(userInfo);
        BusManager.bus.fire(new UpdateUserInfoEvent(userInfo));
        Navigator.of(context).pop();
      } else {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: const Text(StringValues.LOGIN_FAILED)));
      }
    }
  }

  Widget _buildAppBar() =>
      new AppBar(
          elevation: 0.0,
          leading: new IconButton(icon: new Icon(Icons.close),
              color: Colors.grey, onPressed: () => Navigator.of(context).pop())
      );

  Widget _buildActionButton() =>
      _isLoading ? new CircularProgressIndicator()
          : new FloatingActionButton(onPressed: () => _login(context),
        child: const Icon(Icons.send),);

  Widget _buildBody(){
    final Widget divider = new SizedBox(height: 32.0,);
    return new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32.0),
      child: new Column(
        children: <Widget>[
          const Text(StringValues.APP_NAME,
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),),
          divider,
          //表单数据
          new Form(
              key: _formKey,
              child:new Column(
                children: <Widget>[
                  new TextFormField(
                    maxLines: 1,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: StringValues.TEXT_FILED_ACCOUNT_LABEL_TEXT
                    ),
                    validator: (value) => value.isEmpty? StringValues.TEXT_FIELD_ACCOUNT_EMPTY_TEXT
                    :null,
                    onSaved: (value) => this._account = value,
                  ),
                  divider,
                  new TextFormField(
                    maxLines: 1,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: StringValues.TEXT_FILED_PASSWORD_LABEL_TEXT
                    ),
                    validator: (value) => value.isEmpty ? StringValues.TEXT_FIELD_PASSWORD_EMPTY_TEXT
                    :null,
                    onSaved: (value) => this._password = value,

                  )
                ],
              ) ),
          divider,
          //登录按钮
          _buildActionButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget appBar = _buildAppBar();
    final Widget body = _buildBody();
    return new Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: body,
    );
  }
}
