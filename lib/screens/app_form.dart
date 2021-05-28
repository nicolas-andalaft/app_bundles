import 'package:app_bundles/components/app_card.dart';
import 'package:app_bundles/components/container_form_field.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/services/play_store_scraper.dart';
import 'package:flutter/material.dart';
import 'package:app_bundles/database/app_dao.dart';
import 'package:app_bundles/database/bundle_dao.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter/services.dart';

class AppForm extends StatefulWidget {
  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  var formKey = GlobalKey<FormState>();
  int? _bundleIndex;
  List<Bundle>? _bundles;
  App? app;

  void _validateForm() async {
    if (formKey.currentState == null || !formKey.currentState!.validate())
      return;

    final _app = await PlayStoreScraper.getApp(app!.appId!);
    if (_app == null) return;
    app = _app;
    app!.bundleId = _bundles![_bundleIndex!].id;

    AppDao.create(app!).then((result) => Navigator.of(context).pop(result));
  }

  void _getBundleList() {
    BundleDao.readAll().then((bundles) => setState(() => _bundles = bundles));
  }

  void _navigateToBundleForm(BuildContext context) async {
    final data = await Navigator.of(context).pushNamed(RouteNames.bundleForm);
    if (data == null) return;

    setState(() => _getBundleList());
  }

  Future<String?> _getClipBoardData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data == null || data.text == null) return null;

    final _app = await PlayStoreScraper.getApp(data.text!);
    if (_app != null) setState(() => app = _app);
  }

  @override
  void initState() {
    super.initState();
    _getBundleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add new app',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  ContainerFormField(
                    child: AppCard(
                      app: app,
                      iconSize: 90,
                      labelSize: 150,
                    ),
                    labelText: 'App:',
                    isCentered: true,
                    validator: () => app == null ? 'Required' : null,
                  ),
                  SizedBox(height: 10),
                  if (_bundles != null)
                    Builder(builder: (context) {
                      return DropdownButtonFormField<int>(
                        value: _bundleIndex,
                        decoration: InputDecoration(labelText: 'Bundle:'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (value == -1) {
                            _navigateToBundleForm(context);

                            return;
                          }
                          setState(() => _bundleIndex = value!);
                        },
                        items: List.generate(
                            _bundles!.length,
                            (index) => DropdownMenuItem<int>(
                                  child: Text(
                                    _bundles![index].name!,
                                  ),
                                  value: index,
                                )),
                        validator: (value) => value == null ? 'Required' : null,
                      );
                    }),
                ],
              ),
            ),
            TextButton(
              child: Text(
                'Add new bundle',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.bundleForm).then(
                (value) {
                  if (value == null) return;
                  setState(() => _getBundleList());
                  _validateForm();
                },
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton.icon(
              icon: Icon(Icons.phone_android),
              label: Text('Use device app'),
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.appList).then(
                        (value) => value != null
                            ? setState(() => app = value as App)
                            : null,
                      ),
            ),
            SizedBox(height: 10),
            OutlinedButton.icon(
              icon: Icon(Icons.assignment),
              label: Text('Paste PlayStore link'),
              onPressed: _getClipBoardData,
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
                child: Text('Add'),
                onPressed: _validateForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
