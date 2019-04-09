import 'package:flutter/material.dart';
import 'dart:async';
import '../util/data_util.dart';
import '../model/category_info.dart';

class SubmitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubmitPageState();
  }
}

class _SubmitPageState extends State<SubmitPage> {
  Timer _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = new GlobalKey();
  String _url = '',
      _desc = '',
      _nickName = '',
      _category = 'Android';

  void _onSubmit(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Map<String, String> params = {
        'url': _url,
        'desc': _desc,
        'who': _nickName,
        'debug': 'true',
        'type': _category
      };

      await DataUtil.submit(params).then((result) {
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(result.msg)));
        Duration duration = new Duration(milliseconds: 1500);
        _timer = new Timer(duration, () {
          if (!result.error) {
            Navigator.of(context).pop();
          }
        });
      });
    }
  }

  DropdownMenuItem<String> _buildCategoryItems(CategoryInfo info) =>
      new DropdownMenuItem(child: new Text(info.name), value: info.name,);

  Widget _buildDivider() => new SizedBox(height: 16.0,);

  Widget _buildBody() =>new Form(key: _formKey,
      child: new Container(

      ));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
