import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class BundleForm extends StatefulWidget {
  @override
  _BundleFormState createState() => _BundleFormState();
}

class _BundleFormState extends State<BundleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  IconData _icon;

  void _showIconPicker() {
    FlutterIconPicker.showIconPicker(context,
            iconPackMode: IconPack.materialOutline)
        .then((result) {
      setState(() {
        if (result != null && result != _icon) _icon = result;
      });
    });
  }

  void _validateForm() {
    if (!_formKey.currentState.validate() || _icon == null) return;

    Bundle newbundle = Bundle();
    newbundle.name = _nameController.text;
    newbundle.icon = _icon;

    BundleDao.create(newbundle).then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Bundle')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              validator: (text) {
                if (text.isEmpty)
                  return 'Required';
                else
                  return null;
              },
            ),
            RaisedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _icon != null ? Icon(_icon) : Container(),
                  Text('Choose an Icon'),
                ],
              ),
              onPressed: _showIconPicker,
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: _validateForm,
            ),
          ],
        ),
      ),
    );
  }
}
