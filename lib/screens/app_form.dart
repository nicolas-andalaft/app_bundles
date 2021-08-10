import 'package:app_bundles/components/app_card.dart';
import 'package:app_bundles/components/confirm_bottom_sheet.dart';
import 'package:app_bundles/components/container_form_field.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/route_names.dart';
import 'package:app_bundles/services/play_store_scraper.dart';
import 'package:app_bundles/utils/loading_dialog.dart';
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
  bool processedData = false;
  var formKey = GlobalKey<FormState>();
  int? _bundleIndex;
  List<Bundle>? _bundles;
  List<App> appList = [];

  void _validateForm() async {
    if (formKey.currentState == null || !formKey.currentState!.validate())
      return;

    loadingDialog(
        context: context,
        command: () async {
          for (App app in appList) {
            // Set bundle id
            app.bundleId = _bundles![_bundleIndex!].id;

            // Get app icon url if it doesn't have one
            if (app.iconUrl == null) {
              final _app = await PlayStoreScraper.fromAppId(app.appId!);
              app
                ..iconUrl = _app?.iconUrl
                ..title = _app?.title;
            }
          }

          await AppDao.createAll(appList);
        }).then(
      (dynamic value) => Navigator.of(context).pop(true),
    );
  }

  void _checkSharedData(BuildContext context) async {
    if (processedData) return;
    processedData = true;

    final data = ModalRoute.of(context)!.settings.arguments;
    if (data == null) return;

    final _app = await PlayStoreScraper.fromUrl(data as String);
    setState(() => appList.add(_app!));
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

    final _app = await PlayStoreScraper.fromAppId(data.text!);
    if (_app != null) setState(() => appList.add(_app));
  }

  @override
  void initState() {
    super.initState();
    _getBundleList();
  }

  @override
  Widget build(BuildContext context) {
    _checkSharedData(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(RouteNames.home);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
                  child: Text(
                    'Add apps to bundle',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    ContainerFormField(
                      child: SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: appList
                              .map((e) => AppCard(
                                    app: e,
                                    iconSize: 90,
                                    labelSize: 150,
                                    onRemove: () =>
                                        setState(() => appList.remove(e)),
                                  ))
                              .toList(),
                        ),
                      ),
                      labelText: 'App:',
                      isCentered: true,
                      validator: () => appList.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_bundles != null)
                            Builder(builder: (context) {
                              return DropdownButtonFormField<int>(
                                value: _bundleIndex,
                                decoration:
                                    InputDecoration(labelText: 'Bundle:'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) =>
                                    setState(() => _bundleIndex = value!),
                                items: List.generate(
                                    _bundles!.length,
                                    (index) => DropdownMenuItem<int>(
                                          child: Text(
                                            _bundles![index].name!,
                                          ),
                                          value: index,
                                        )),
                                validator: (value) =>
                                    value == null ? 'Required' : null,
                              );
                            }),
                          TextButton(
                            child: Text(
                              'Add new bundle',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            onPressed: () => _navigateToBundleForm(context),
                          ),
                          SizedBox(height: 20),
                          OutlinedButton.icon(
                            icon: Icon(Icons.phone_android),
                            label: Text('Use device apps'),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(RouteNames.appList)
                                .then(
                                  (value) => value != null
                                      ? setState(() =>
                                          appList.addAll(value as List<App>))
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: ConfirmBottomSheet(
          yesTitle: 'Add',
          noTitle: 'Cancel',
          yesFunction: _validateForm,
          noFunction: () => Navigator.of(context).pop,
        ),
      ),
    );
  }
}
