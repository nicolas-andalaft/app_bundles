import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';

import 'package:flutter/material.dart';

class BookmarkForm extends StatefulWidget {
  @override
  _BookmarkFormState createState() => _BookmarkFormState();
}

class _BookmarkFormState extends State<BookmarkForm> {
  final _formKey = GlobalKey<FormState>();
  final _appLinkController = TextEditingController();
  int _bundleIndex = 0;
  List<Bundle> _bundles = List();

  void _getBundleList() {
    BundleDao.readAll().then((data) => setState(() => _bundles = data));
  }

  @override
  void initState() {
    _getBundleList();
    super.initState();
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
              controller: _appLinkController,
              validator: (text) {
                if (text.isEmpty)
                  return 'Required';
                else
                  return null;
              },
            ),
            Wrap(
              spacing: 10,
              children: List.generate(
                _bundles.length,
                (index) => ChoiceChip(
                  label: Text('${_bundles[index].name}'),
                  selected: _bundleIndex == index,
                  onSelected: (bool selected) =>
                      setState(() => _bundleIndex = index),
                ),
              ),
            ),
            FlatButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .pushNamed('/bundleform')
                  .whenComplete(() => _getBundleList()),
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                App newapp = App();
                newapp.appId = _appLinkController.text;
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
