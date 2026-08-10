@echo off
setlocal EnableExtensions

set "SRC=D:\Cloud\Dropbox\NewLoginGit"
set "DST=D:\Cloud\Dropbox\NewLoginVT"

echo ================================================
echo Copy danh sach FIX CUNG tu NewLoginGit sang NewLoginVT
echo ================================================

echo [FOLDER] ApisCongCanBo
if exist "%SRC%\ApisCongCanBo\" (
    robocopy "%SRC%\ApisCongCanBo" "%DST%\ApisCongCanBo" /E /COPY:DAT /DCOPY:DAT /R:1 /W:1
) else (
    echo [KHONG TIM THAY] %SRC%\ApisCongCanBo
)

echo [FOLDER] ApisCongSinhVien
if exist "%SRC%\ApisCongSinhVien\" (
    robocopy "%SRC%\ApisCongSinhVien" "%DST%\ApisCongSinhVien" /E /COPY:DAT /DCOPY:DAT /R:1 /W:1
) else (
    echo [KHONG TIM THAY] %SRC%\ApisCongSinhVien
)

echo [FOLDER] assets
if exist "%SRC%\assets\" (
    robocopy "%SRC%\assets" "%DST%\assets" /E /COPY:DAT /DCOPY:DAT /R:1 /W:1
) else (
    echo [KHONG TIM THAY] %SRC%\assets
)

echo [FOLDER] Core
if exist "%SRC%\Core\" (
    robocopy "%SRC%\Core" "%DST%\Core" /E /COPY:DAT /DCOPY:DAT /R:1 /W:1
) else (
    echo [KHONG TIM THAY] %SRC%\Core
)

echo [FILE] index.aspx
if exist "%SRC%\index.aspx" (
    copy /Y "%SRC%\index.aspx" "%DST%\index.aspx" >nul
) else (
    echo [KHONG TIM THAY] %SRC%\index.aspx
)

echo ================================================
echo Hoan tat.
echo ================================================
pause
endlocal