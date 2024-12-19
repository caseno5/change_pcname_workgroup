@echo off
cd /d %~dp0

rem 一意のワークグループに所属させ、任意のコンピュータ名に変更する

echo 必ず管理者権限をつけて実行して下さい。
echo 管理者権限がない場合は、一度閉じて管理者権限をつけて実行して下さい。

echo PC名を変更し、ワークグループをCASENO5にします。
echo;

echo ワークグループをCASENO5に変更します。
echo;
wmic computersystem where name="%computername%" call joindomainorworkgroup name="CASENO5"
echo;

echo ReturnValueが0でない場合、またはインスタンスがどうのと言われる場合は失敗です。管理者権限で実行し直して下さい。
echo 再起動後に再度実行が必要な場合もあります。何にしろ、ReturnValue = 0が出ないなら再実行です。
echo;

echo 現在のPC名は
hostname
echo です。
echo;
set /p pcchangename=新しいPC名を入力して下さい:
echo;

echo レジストリ初期化開始
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t "REG_SZ" /d "" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t "REG_SZ" /d "" /f
echo 初期化完了
echo;

echo 書込開始
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t "REG_SZ" /d "%pcchangename%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t "REG_SZ" /d "%pcchangename%" /f
echo;

echo wmic書込開始
wmic computersystem where name="%computername%" call rename name="%pcchangename%"
echo;

echo 処理は終了しました。
echo ReturnValueが0でない場合、またはインスタンスがどうのと言われる場合は失敗です。管理者権限で実行し直して下さい。
echo;

echo 再起動後に再度実行が必要な場合もあります。何にしろ、ReturnValue = 0が出ないなら再実行です。
echo 設定反映には必ず再起動処理が必要です。
echo この後、再起動処理を入れていますし、バッチを途中終了する場合は再起動して下さい。
echo;
pause;

echo キーを押したら再起動します。
pause;

shutdown -r -t 0
exit 0

rem 本バッチファイルはMITライセンスで提供されます
rem CaseNo.5 | MIT License | https://caseno5.hatenablog.com/ | https://github.com/caseno5/
rem 
