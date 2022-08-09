import 'package:flutter/material.dart';
import 'package:slide_screen_saver/view/slide_show/slide_show_app.dart';
import 'package:window_manager/window_manager.dart';

// window_manager パッケージを使う場合、
// 初回ビルド？に管理者権限（または開発者モードの有効化）が必要
// 一度、管理者権限のPowerShellにて下記コマンドを実行することで、
// 以後はVSCodeのデバッグ起動が可能となる
// flutter run -d windows

void main(List<String> args) async {
  // WindowManagerで制御する前にFlutterを初期化する
  // これをやらないとWindowManager処理実行時にウィンドウが未生成のためエラーとなる
  // WidgetsFlutterBinding.ensureInitialized();

  // アプリ開始
  runApp(const SlideShowApp());

  // WindowManager初期化
  await windowManager.ensureInitialized();

  // フルスクリーン化
  windowManager.setFullScreen(true);
  windowManager.show();
}
