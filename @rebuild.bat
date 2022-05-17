@echo off

:: window_manager パッケージのビルドには管理者権限が必要

:: 管理者権限でない場合は昇格要求
if not "%~1" == "ADMINMODE" (
  powershell "start-process -FilePath '%~dpnx0' -ArgumentList 'ADMINMODE' -verb runas"
  exit /b
)
:: 以下管理者権限

:: バッチファイルのディレクトリへ移動
cd /d %~dp0

:: Windows向けリビルド
call flutter clean
call flutter build windows
pause
