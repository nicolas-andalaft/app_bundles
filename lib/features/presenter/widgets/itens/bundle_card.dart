import 'package:flutter/material.dart';

import '../../../domain/entities/bundle_entity.dart';
import '../../pages/pages.dart' show BundleScreen;

class BundleCard extends StatelessWidget {
  final double _height = 150;
  final BundleEntity bundle;
  BundleCard(this.bundle);

  Widget _background(BuildContext context) {
    final cardColor = Theme.of(context).accentColor;
    return ShaderMask(
      blendMode: BlendMode.srcOver,
      shaderCallback: (rect) {
        return LinearGradient(
          colors: [
            cardColor,
            cardColor.withAlpha(0),
          ],
          stops: [0.3, 0.8],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      child: Container(
        height: _height,
        width: double.infinity,
        color: cardColor,
        child: Image.asset(
          'assets/background_pattern.png',
          fit: BoxFit.cover,
          color: Colors.white10,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _label(BuildContext context, {Function()? onTap}) {
    return SizedBox(
      height: _height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                Icon(
                  bundle.icon,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bundle.name!,
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 35,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _background(context),
          _label(
            context,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BundleScreen(bundle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
