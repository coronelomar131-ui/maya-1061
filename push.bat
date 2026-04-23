@echo off
REM Script automático para hacer push a GitHub
cd /d "%~dp0"

echo 📦 Agregando cambios...
git add .

echo 💾 Creando commit...
git commit -m "⚡ Auto-commit: %date% %time%" || echo "Sin cambios nuevos"

echo 🚀 Pusheando a GitHub...
git push

echo ✅ ¡Listo! Cambios pusheados a GitHub
pause
