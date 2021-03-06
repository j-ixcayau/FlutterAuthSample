import 'package:auth/localization/Internationalization.dart';
import 'package:auth/utils/Utils.dart';
import 'package:auth/widgets/ChangeLocaleIcon.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool showLanguage;
  final Widget trailing;

  CommonAppbar({this.showLanguage = false, this.trailing});

  @override
  _CommonAppbarState createState() => _CommonAppbarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _CommonAppbarState extends State<CommonAppbar> {
  Internationalization _int;

  @override
  Widget build(BuildContext context) {
    _int = Internationalization(context);

    return AppBar(
      title: Text(
        _int.getString(samplesKey),
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      actions: [
        (widget.showLanguage) ? ChangeLocaleIcon() : SizedBox(),
        (widget.trailing != null) ? widget.trailing : SizedBox()
      ],
    );
  }
}
