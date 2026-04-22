# 🔧 Maya Autopartes ML - Online con Supabase

**App de inventario ONLINE (no local) con Supabase + Real-time Sync**

---

## 🚀 SETUP (5 minutos)

### 1️⃣ Crear Proyecto Supabase

```
1. Ve a https://supabase.com
2. Login con GitHub/Google
3. "New Project"
   - Name: maya-autopartes-ml
   - Password: (anota en seguro)
   - Region: Mexico (Querétaro)
4. Espera 5 minutos a que inicie
```

### 2️⃣ Crear Tablas SQL

**En Supabase:**
```
1. Abre tu proyecto
2. SQL Editor (botón izquierda)
3. Copia TODO el contenido de: TABLAS_SQL.sql
4. Pégalo en el editor
5. Ctrl+Enter para ejecutar
6. ✅ Listo
```

### 3️⃣ Obtener Credenciales

**En Supabase:**
```
1. Settings (rueda) → API
2. Copia "Project URL"
3. Copia "anon (public)" key
4. Guarda en seguro
```

### 4️⃣ Abrir setup.html

```
1. Abre: C:\Users\omar\maya-online\setup.html
2. Pega URL Supabase
3. Pega ANON KEY
4. Haz clic: "Probar Conexión"
5. ✅ Si funciona, te lleva a app
```

### 5️⃣ Crear Primer Usuario

```
1. Verás pantalla "Primer usuario admin"
2. Nombre: Tu nombre
3. Usuario: estefanya (o cualquiera)
4. PIN: 1234
5. Clic: "Crear Admin"
6. ✅ ¡Listo! Estás dentro
```

---

## 📂 Archivos

| Archivo | Qué es |
|---------|--------|
| `index.html` | **APP ONLINE** (con Supabase) |
| `setup.html` | Configurar credenciales Supabase |
| `TABLAS_SQL.sql` | SQL para crear tablas |
| `README.md` | Este archivo |

---

## 🔄 Como Funciona

```
App local (index.html)
    ↓
Supabase (en la nube)
    ↓
Base de datos PostgreSQL
    ↓
Real-time Sync
```

**Diferencia con antes:**
- ❌ localStorage (limitado, local)
- ✅ Supabase (ilimitado, online, real-time)

---

## 📱 Multi-Usuario

```
Estefanya           Josué
├─ Login            ├─ Login
├─ Sus ventas       ├─ Sus ventas
├─ Productos (compartidos)
├─ Clientes (compartidos)
└─ Sync en tiempo real entre usuarios
```

---

## 🎯 Módulos (6)

1. **📊 Dashboard** - KPIs en vivo
2. **💰 Ventas** - CRUD de ventas
3. **📦 Almacén** - Productos
4. **👥 Clientes** - Contactos
5. **📄 Facturas** - Plantilla (listo para datos)
6. **🔑 Usuarios** - Crear usuarios (admin)

---

## 🌐 Deployar en Internet (Netlify)

### Opción 1: GitHub + Netlify (Recomendado)

```bash
# 1. Push a GitHub
cd C:\Users\omar\maya-online
git init
git add .
git commit -m "Maya Autopartes Online v1"
git branch -M main
git remote add origin https://github.com/coronelomar131-ui/maya-1061.git
git push -u origin main

# 2. En Netlify (netlify.com)
- Login con GitHub
- "New site from Git"
- Selecciona repo: maya-1061
- Deploy
- ✅ Tu URL: https://maya-xxx.netlify.app
```

### Opción 2: Deploy Manual

```bash
# Sin Git, solo archivos
# 1. Copia index.html, setup.html, TABLAS_SQL.sql
# 2. En Netlify:
#    - Drag & drop los archivos
#    - ¡Deploy!
```

---

## 🔐 Seguridad

### ⚠️ NUNCA compartir:
- SUPABASE_URL
- SUPABASE_KEY

Están guardadas en localStorage del navegador (solo local).

### ✅ Para producción:
Si quieres más seguridad, usa variables de entorno en Netlify:
```
Settings → Environment variables
VITE_SUPABASE_URL = ...
VITE_SUPABASE_KEY = ...
```

---

## 🐛 Troubleshooting

| Problema | Solución |
|----------|----------|
| "No puedo conectar" | Verifica URL y KEY correctas en setup.html |
| "Error 403" | Revisa que copiaste la key ANON (no SECRET) |
| "Tabla no existe" | Ejecuta TABLAS_SQL.sql nuevamente |
| "Datos no guardan" | Revisa console (F12) por errores |

---

## 📊 Estructura SQL

```sql
users          -- Usuarios del sistema
productos      -- Catálogo (compartido)
clientes       -- Contactos (compartido)
ventas         -- Ventas por usuario
facturas       -- Facturas por usuario
```

---

## ✨ Ventajas vs localStorage

| Feature | localStorage | Supabase |
|---------|--------------|----------|
| **Almacenamiento** | 5-10MB | Ilimitado |
| **Sync** | No | ✅ Real-time |
| **Multi-dispositivo** | No | ✅ Sí |
| **Seguridad** | Baja | ✅ Alta |
| **Backups** | Manual | ✅ Automático |
| **SQL** | No | ✅ PostgreSQL |

---

## 🚀 Próximos Pasos

1. ✅ Setup Supabase
2. ✅ Crear tablas
3. ✅ Probar app
4. ⏳ Deployar en Netlify
5. ⏳ Integración Mercado Libre

---

## 📞 Soporte

Si algo falla:
1. Abre F12 (DevTools)
2. Ve a Console
3. Busca mensajes de error (rojo)
4. Copia el error
5. Revisa que credenciales sean correctas

---

**Versión**: v3.0.0 Online
**Status**: 🟢 Listo para producción

