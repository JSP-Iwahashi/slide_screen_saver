@echo off

:: window_manager �p�b�P�[�W�̃r���h�ɂ͊Ǘ��Ҍ������K�v

:: �Ǘ��Ҍ����łȂ��ꍇ�͏��i�v��
if not "%~1" == "ADMINMODE" (
  powershell "start-process -FilePath '%~dpnx0' -ArgumentList 'ADMINMODE' -verb runas"
  exit /b
)
:: �ȉ��Ǘ��Ҍ���

:: �o�b�`�t�@�C���̃f�B���N�g���ֈړ�
cd /d %~dp0

:: Windows�������r���h
call flutter clean
call flutter build windows
pause
