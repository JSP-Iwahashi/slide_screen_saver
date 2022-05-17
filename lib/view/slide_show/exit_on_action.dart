import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ExitOnAction extends StatefulWidget {
  const ExitOnAction({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return ExitOnActionState();
  }
}

class ExitOnActionState extends State<ExitOnAction> {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (e) {
        // リリースビルドの場合は即時終了
        // デバッグの場合はEscの場合だけ即時終了
        if (!kDebugMode || e.logicalKey == LogicalKeyboardKey.escape) {
          exit(0);
        }
      },
      child: MouseRegion(
        onHover: (event) {
          // リリースビルドの場合はマウス移動で即時終了
          // デバッグの場合は何もしない
          if (kDebugMode || first) {
            first = false;
          } else {
            exit(0);
          }
        },
        child: widget.child,
      ),
    );
  }
}
