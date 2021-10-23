import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../../domain/entities/bundle_entity.dart';
import '../../bloc/bundle_bloc.dart';
import '../../bloc/bundle_event.dart';
import '../../widgets/widgets.dart';

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

  void _validateForm(BuildContext context) {
    if (formKey.currentState == null || !formKey.currentState!.validate())
      return;

    final bundle = BundleEntity(
      name: nameController.text,
      icon: icon,
    );

    BundleBloc().add(CreateBundleEvent(bundle));

    Navigator.of(context).pop(0);
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
      bottomSheet: ConfirmBottomSheet(
        yesTitle: 'Create',
        yesFunction: () => _validateForm(context),
        noTitle: 'Cancel',
        noFunction: () => Navigator.of(context).pop(),
      ),
    );
  }
}
