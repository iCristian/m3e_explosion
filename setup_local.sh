#!/bin/bash
# setup_local.sh - Script para configurar valores locales (NO versionado)
# Ejecutar SOLO localmente después de clonar el repo

echo "🔐 Configuración Local de M3E Explosion"
echo "======================================"
echo ""
echo "Este script configura tu máquina con valores privados."
echo "Los cambios realizados NO serán versionados en Git."
echo ""

# Crear archivo .env local
read -p "¿Deseas crear un archivo .env.local? (s/n): " create_env
if [ "$create_env" = "s" ] || [ "$create_env" = "S" ]; then
    cp .env.example .env.local
    echo "✅ .env.local creado"
    echo "   Edita el archivo y agrega tus datos personales:"
    echo "   nano .env.local"
fi

# Actualizar Android bundle ID
read -p "¿Deseas actualizar el Bundle ID de Android? (s/n): " update_android
if [ "$update_android" = "s" ] || [ "$update_android" = "S" ]; then
    read -p "Ingresa el Bundle ID (ej: com.cristiancarreno.m3eexplosion): " bundle_id
    sed -i '' "s/com.example.m3e_demo/$bundle_id/g" android/app/build.gradle.kts
    echo "✅ Bundle ID de Android actualizado a: $bundle_id"
fi

# Configurar iOS bundle ID
read -p "¿Deseas actualizar el Bundle ID de iOS? (s/n): " update_ios
if [ "$update_ios" = "s" ] || [ "$update_ios" = "S" ]; then
    read -p "Ingresa el Bundle ID (ej: com.cristiancarreno.m3eexplosion): " bundle_id
    # Esto requiere Xcode y es más complejo, solo mostrar instrucción
    echo "⚠️  Para iOS, abre Xcode:"
    echo "   1. ios/Runner.xcworkspace/contents.xcworkspacedata"
    echo "   2. Cambiar Bundle Identifier en Build Settings"
    echo "   3. Búscar 'Bundle Identifier' y actualizar"
fi

echo ""
echo "✅ Configuración completada!"
echo ""
echo "⚠️  IMPORTANTE:"
echo "   1. Edita .env.local con tus datos personales"
echo "   2. Nunca comits archivos con datos sensibles"
echo "   3. Verifica el .gitignore antes de hacer push"
echo ""
