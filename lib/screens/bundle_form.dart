import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';

import 'package:flutter/material.dart';

class BundleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();

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
              child: Text('Add'),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                Bundle newbundle = Bundle();
                newbundle.name = _nameController.text;
                BundleDao.create(newbundle).then((_) => Navigator.pop(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
