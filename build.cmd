@echo off
setlocal EnableExtensions
set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "AAPT=%SDK%\build-tools\36.0.0\aapt2.exe"
set "ZIPALIGN=%SDK%\build-tools\36.0.0\zipalign.exe"
set "SIGNER=%SDK%\build-tools\36.0.0\apksigner.bat"
set "ANDROIDJAR=%SDK%\platforms\android-36\android.jar"
if not exist "%AAPT%" (echo ERROR: aapt2 missing & exit /b 1)
if not exist "%ANDROIDJAR%" (echo ERROR: android.jar missing & exit /b 1)
if not exist "%SIGNER%" (echo ERROR: apksigner missing & exit /b 1)
if not exist "%ZIPALIGN%" (echo ERROR: zipalign missing & exit /b 1)
where keytool >nul 2>nul || (echo ERROR: keytool missing. Add Android Studio jbr\bin to PATH. & exit /b 1)
if not exist build mkdir build
"%AAPT%" compile --dir overlay\res -o build\compiled.zip || exit /b 1
"%AAPT%" link -o build\unsigned.apk --manifest overlay\AndroidManifest.xml -I "%ANDROIDJAR%" --auto-add-overlay build\compiled.zip || exit /b 1
"%ZIPALIGN%" -f 4 build\unsigned.apk build\aligned.apk || exit /b 1
if not exist build\release.keystore keytool -genkeypair -keystore build\release.keystore -storepass android -keypass android -alias overlay -keyalg RSA -keysize 2048 -validity 3650 -dname "CN=NX789J Overlay" -noprompt || exit /b 1
call "%SIGNER%" sign --ks build\release.keystore --ks-key-alias overlay --ks-pass pass:android --key-pass pass:android --out build\NX789JAutoBrightness.apk build\aligned.apk || exit /b 1
call "%SIGNER%" verify build\NX789JAutoBrightness.apk || exit /b 1
powershell -NoProfile -ExecutionPolicy Bypass -File package.ps1 || exit /b 1
echo SUCCESS: NX789J-AutoBrightness-Magisk.zip
