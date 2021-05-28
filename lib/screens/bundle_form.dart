import 'package:app_bundles/components/container_form_field.dart';
import 'package:flutter/material.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class BundleForm extends StatefulWidget {
  @override
  _BundleFormState createState() => _BundleFormState();
}

class _BundleFormState extends State<BundleForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  IconData? icon;

  void _showIconPicker() {
    FlutterIconPicker.showIconPicker(
      context,
      iconPackMode: IconPack.material,
      iconSize: 30,
    ).then(
      (result) {
        if (result == null || result == icon) return;
        setState(() => icon = result);
        formKey.currentState?.validate();
      },
    );
  }

  void _validateForm() {
    if (formKey.currentState == null || !formKey.currentState!.validate())
      return;

    Bundle newbundle = Bundle()
      ..name = nameController.text
      ..icon = icon;

    BundleDao.create(newbundle)
        .then((result) => Navigator.pop(context, result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Text(
              'Create new Bundle',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 40),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name:'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose an icon:',
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                  IconButton(
                    icon: icon != null
                        ? Icon(icon)
                        : Icon(
                            Icons.add,
                            color: Theme.of(context).disabledColor,
                          ),
                    iconSize: 80,
                    onPressed: _showIconPicker,
                  ),
                  ContainerFormField(
                    validator: () => icon == null ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                child: Text('Create'),
                onPressed: _validateForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
