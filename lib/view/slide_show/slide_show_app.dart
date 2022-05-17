import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slide_screen_saver/view/slide_show/clock.dart';
import 'package:slide_screen_saver/view/slide_show/exit_on_action.dart';
import 'package:slide_screen_saver/view/slide_show/image_with_background.dart';

const int assetImagesMin = 1;
const int assetImagesMax = 10;

class SlideShowApp extends StatefulWidget {
  const SlideShowApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SlideShowAppState();
  }
}

class _SlideShowAppState extends State<SlideShowApp> {
  final List<String> _assets = [];
  final List<int> _indexes = [];
  String _front = '';
  String _back = '';
  int _lastFlip = 0;
  int _lastLoad = 0;
  bool _frontVisible = false;

  void _generateIndexes() {
    for (var i = assetImagesMin; i < assetImagesMax; i++) {
      _indexes.add(i);
    }
    _indexes.shuffle();
  }

  String _nextAsset() {
    if (_indexes.isEmpty) _generateIndexes();
    return _assets[_indexes.removeLast()];
  }

  @override
  void initState() {
    // アセット一覧リストの作成
    for (var i = assetImagesMin; i <= assetImagesMax; i++) {
      String n = '0' + i.toString();
      n = n.substring(n.length - 2);
      _assets.add('assets/images/' + n + '.jpg');
    }

    // 画像をランダムに選択
    _front = _nextAsset();
    _back = _nextAsset();

    // 次の画像入替時刻をセット
    _lastFlip = DateTime.now().millisecondsSinceEpoch;
    _lastLoad = _lastFlip + 1000;

    // 5秒おきに画像を入替
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        setState(
          () {
            int now = DateTime.now().millisecondsSinceEpoch;

            // 5秒経過していたらフリップ
            if (_lastFlip <= now - 5000) {
              _lastFlip += 5000;
              _frontVisible = !_frontVisible;
            }

            // 4秒経過していたら見えない方のImageに別画像をセット
            if (_lastLoad <= now - 5000) {
              _lastLoad += 5000;
              if (_frontVisible) {
                _back = _nextAsset();
              } else {
                _front = _nextAsset();
              }
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExitOnAction(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Stack(
              children: [
                ImageWithBackground(asset: _back),
                AnimatedOpacity(
                  opacity: _frontVisible ? 1.0 : 0.0,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  child: ImageWithBackground(asset: _front),
                ),
                const Clock()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
