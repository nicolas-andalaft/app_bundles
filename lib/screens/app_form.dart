import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';

import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  final String appId;
  const AppForm({this.appId});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  final _formKey = GlobalKey<FormState>();
  final _appIdController = TextEditingController();
  int _bundleIndex = 0;
  List<Bundle> _bundles;

  void _getBundleList() {
    BundleDao.readAll().then((data) => setState(() => _bundles = data));
  }

  @override
  void initState() {
    super.initState();
    _getBundleList();
    _appIdController.text = widget.appId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New App')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _appIdController,
              validator: (text) {
                if (text.isEmpty)
                  return 'Required';
                else
                  return null;
              },
            ),
            Wrap(
              spacing: 10,
              children: [
                Wrap(
                  spacing: 10,
                  children: List.generate(
                    _bundles != null ? _bundles.length : 0,
                    (index) => ChoiceChip(
                      label: Text('${_bundles[index].name}'),
                      selected: _bundleIndex == index,
                      onSelected: (bool selected) =>
                          setState(() => _bundleIndex = index),
                    ),
                  ),
                ),
                ActionChip(
                    label: Icon(Icons.refresh),
                    onPressed: () => _getBundleList()),
                ActionChip(
                  label: Icon(Icons.add),
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/bundleform')
                      .whenComplete(() => _getBundleList()),
                ),
              ],
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                App newapp = App();
                newapp.appId = _appIdController.text;
                newapp.bundleId = _bundles[_bundleIndex].id;
                AppDao.create(newapp).then((_) => Navigator.pop(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
