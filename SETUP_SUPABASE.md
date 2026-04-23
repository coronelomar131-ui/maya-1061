# 🚀 Setup Multi-Usuario Online con Supabase

## Paso 1: Ejecutar SQL en Supabase

1. Ve a: **https://supabase.com/dashboard**
2. Entra a tu proyecto **maya-autopartes**
3. Abre: **SQL Editor** → **New Query**
4. **Copia todo el contenido** de `SUPABASE_MULTI_USER.sql`
5. **Pega** en el editor de SQL
6. Haz clic en **▶ RUN** (botón verde)
7. ✅ Espera a que se complete

## Paso 2: Verifica las tablas

En **Table Editor**, deberías ver:
- ✅ usuarios
- ✅ productos
- ✅ clientes
- ✅ ventas
- ✅ entregas
- ✅ facturas

Cada una con RLS habilitado.

## Paso 3: App ya está configurada

El archivo `index.html` ya tiene:
- ✅ Conexión automática a Supabase
- ✅ Real-time sync en background
- ✅ Multi-usuario login
- ✅ Sincronización de cambios

## Credenciales usadas

```
URL: https://cqyxyyqcioqygeikmuxa.supabase.co
Key: sb_publishable_H8PKOeQ4YMRtR4ZUb3CQDg_48hNW8dD
```

(Si necesitas cambiarlas, edita el archivo `index.html` línea ~1527)

## Características

### ✅ Multi-Usuario
- Admin puede crear usuarios con PIN
- Cada usuario se autentica con usuario + PIN
- 4 dígitos de PIN (seguro)

### ✅ Tiempo Real
- Cambios en productos se ven al instante
- Nuevos clientes aparecen en todos los navegadores
- Ventas se sincronizan automáticamente

### ✅ Compartido
- Productos: ven todos
- Clientes: ven todos
- Ventas/Entregas: ven todos pero saben quién las creó

### ✅ Offline-First
- Si se cae internet, sigue funcionando con datos locales
- Cuando vuelve conexión, sincroniza automáticamente

## Test Rápido

1. Abre en 2 navegadores diferentes (o 2 pestañas)
2. Login con **admin** / **1234**
3. En navegador 1: Agrega un producto
4. En navegador 2: ¡Deberías verlo aparecer automáticamente!

## 🔧 Troubleshooting

### Si no sincroniza en tiempo real:
1. Verifica que RLS esté **ENABLED** (en Supabase → Authentication → Policies)
2. Recarga la página (Ctrl+R)
3. Abre consola (F12) para ver errores

### Si hay errores de "Unauthorized":
1. Ve a Supabase → SQL Editor
2. Ejecuta de nuevo el SQL (paso 1)
3. Reinicia la app

### Si quieres deshabilitar RLS (menos seguro):
```sql
ALTER TABLE productos DISABLE ROW LEVEL SECURITY;
ALTER TABLE clientes DISABLE ROW LEVEL SECURITY;
ALTER TABLE ventas DISABLE ROW LEVEL SECURITY;
ALTER TABLE entregas DISABLE ROW LEVEL SECURITY;
ALTER TABLE facturas DISABLE ROW LEVEL SECURITY;
ALTER TABLE usuarios DISABLE ROW LEVEL SECURITY;
```

---

¡Listo! Ahora tienes una app **multi-usuario, online y en tiempo real** 🎉
