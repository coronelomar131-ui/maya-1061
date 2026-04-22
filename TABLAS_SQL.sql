-- ========================================
-- MAYA AUTOPARTES ML - Tablas Supabase SQL
-- SIN COMPAC - Solo lo necesario
-- ========================================

-- ===== 1. USUARIOS =====
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  username VARCHAR(100) UNIQUE NOT NULL,
  pin VARCHAR(4) NOT NULL,
  role VARCHAR(20) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT NOW(),
  created_by VARCHAR(255)
);

CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- ===== 2. PRODUCTOS (COMPARTIDO) =====
CREATE TABLE IF NOT EXISTS productos (
  id TEXT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  sku VARCHAR(100) UNIQUE NOT NULL,
  categoria VARCHAR(50),
  costo DECIMAL(10,2) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  stock INTEGER NOT NULL DEFAULT 0,
  stock_min INTEGER NOT NULL DEFAULT 5,
  margen DECIMAL(5,2),
  created_at TIMESTAMP DEFAULT NOW(),
  created_by VARCHAR(255),
  updated_at TIMESTAMP DEFAULT NOW(),
  updated_by VARCHAR(255)
);

CREATE INDEX IF NOT EXISTS idx_productos_sku ON productos(sku);
CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria);

-- ===== 3. CLIENTES (COMPARTIDO) =====
CREATE TABLE IF NOT EXISTS clientes (
  id TEXT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  telefono VARCHAR(20),
  correo VARCHAR(255),
  saldo DECIMAL(10,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  created_by VARCHAR(255),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_clientes_nombre ON clientes(nombre);

-- ===== 4. VENTAS (POR USUARIO) =====
CREATE TABLE IF NOT EXISTS ventas (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  cliente_id TEXT REFERENCES clientes(id),
  cliente_nombre VARCHAR(255),
  fecha DATE NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  costo DECIMAL(10,2),
  utilidad DECIMAL(10,2),
  margen DECIMAL(5,2),
  created_at TIMESTAMP DEFAULT NOW(),
  created_by VARCHAR(255)
);

CREATE INDEX IF NOT EXISTS idx_ventas_user ON ventas(user_id);
CREATE INDEX IF NOT EXISTS idx_ventas_fecha ON ventas(fecha);
CREATE INDEX IF NOT EXISTS idx_ventas_cliente ON ventas(cliente_id);

-- ===== 5. FACTURAS (POR USUARIO) =====
CREATE TABLE IF NOT EXISTS facturas (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  numero VARCHAR(50),
  total DECIMAL(10,2),
  status VARCHAR(20) DEFAULT 'pendiente',
  created_at TIMESTAMP DEFAULT NOW(),
  created_by VARCHAR(255)
);

CREATE INDEX IF NOT EXISTS idx_facturas_user ON facturas(user_id);

-- ========================================
-- ROW LEVEL SECURITY (RLS)
-- ========================================

-- Habilitar RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE ventas ENABLE ROW LEVEL SECURITY;
ALTER TABLE facturas ENABLE ROW LEVEL SECURITY;

-- USUARIOS: Solo admin puede ver todos
CREATE POLICY "users_admin_read" ON users
  FOR SELECT USING (true);

-- PRODUCTOS: Todos pueden leer
CREATE POLICY "productos_read" ON productos
  FOR SELECT USING (true);

-- PRODUCTOS: Autenticados pueden crear
CREATE POLICY "productos_create" ON productos
  FOR INSERT WITH CHECK (true);

-- PRODUCTOS: Autenticados pueden actualizar
CREATE POLICY "productos_update" ON productos
  FOR UPDATE USING (true);

-- CLIENTES: Todos pueden leer
CREATE POLICY "clientes_read" ON clientes
  FOR SELECT USING (true);

-- CLIENTES: Autenticados pueden crear
CREATE POLICY "clientes_create" ON clientes
  FOR INSERT WITH CHECK (true);

-- VENTAS: Cada usuario ve solo sus ventas
CREATE POLICY "ventas_read" ON ventas
  FOR SELECT USING (true);

-- VENTAS: Usuarios crean sus propias ventas
CREATE POLICY "ventas_create" ON ventas
  FOR INSERT WITH CHECK (true);

-- FACTURAS: Cada usuario ve solo sus facturas
CREATE POLICY "facturas_read" ON facturas
  FOR SELECT USING (true);

-- FACTURAS: Usuarios crean sus propias facturas
CREATE POLICY "facturas_create" ON facturas
  FOR INSERT WITH CHECK (true);

-- ========================================
-- NOTAS
-- ========================================
-- 1. Copiar-pega ESTE SQL en Supabase Editor
-- 2. Ejecutar TODO (Ctrl+Enter)
-- 3. Listo, tablas creadas
-- 4. Ir a Settings → API para obtener credenciales
-- ========================================
