import 'package:app_bundles/features/presenter/bloc/bundle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/route_names.dart';
import '../../bloc/bundle_bloc.dart';
import '../../widgets/widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          children: [
            Text(
              'AppBundles',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 40),
            Text(
              'Your Bundles',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            buildBody(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed(RouteNames.appForm)
          // .then((value) => setState(() {
          //       _getBundles();
          //     })),
          ),
    );
  }

  BlocProvider<BundleBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => BundleBloc(),
      child: BlocBuilder<BundleBloc, BundleState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case Empty:
              return Text(
                "You don't have any bundles yet",
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              );
            case Loading:
              return CircularProgressIndicator();
            case Loaded:
              return Column(
                children: (state as Loaded)
                    .bundles
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: BundleCard(e),
                        ))
                    .toList(),
              );
            default:
              return Text(
                "Bundles coun't be loaded",
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              );
          }
        },
      ),
    );
  }
}
