-- ========================================
-- MAYA AUTOPARTES - Multi-Usuario con Supabase
-- Ejecutar en: https://supabase.com/dashboard
-- ========================================

-- Limpiar tablas existentes
DROP TABLE IF EXISTS facturas CASCADE;
DROP TABLE IF EXISTS entregas CASCADE;
DROP TABLE IF EXISTS ventas CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

-- ===== USUARIOS (con PIN) =====
CREATE TABLE usuarios (
  id BIGINT PRIMARY KEY,
  usuario VARCHAR(100) UNIQUE NOT NULL,
  pin VARCHAR(4) NOT NULL,
  nombre VARCHAR(255),
  rol VARCHAR(50) DEFAULT 'user',
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== PRODUCTOS (ALMACÉN - Compartido) =====
CREATE TABLE productos (
  id BIGINT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  sku VARCHAR(100) UNIQUE,
  categoria VARCHAR(100),
  stock DECIMAL(10,2) DEFAULT 0,
  min DECIMAL(10,2) DEFAULT 5,
  max DECIMAL(10,2) DEFAULT 100,
  costo DECIMAL(10,2) DEFAULT 0,
  precio DECIMAL(10,2) DEFAULT 0,
  notas TEXT,
  created_by BIGINT REFERENCES usuarios(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== CLIENTES (Compartido) =====
CREATE TABLE clientes (
  id BIGINT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  tipo VARCHAR(100),
  responsable VARCHAR(255),
  rfc VARCHAR(50),
  tel VARCHAR(20),
  email VARCHAR(255),
  credito DECIMAL(10,2) DEFAULT 0,
  diasCred INT DEFAULT 30,
  direccion TEXT,
  notas TEXT,
  created_by BIGINT REFERENCES usuarios(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== VENTAS (Por usuario + compartido) =====
CREATE TABLE ventas (
  id BIGINT PRIMARY KEY,
  fecha DATE NOT NULL,
  cliente_id BIGINT REFERENCES clientes(id),
  cliente VARCHAR(255),
  direccion TEXT,
  cantidad INT DEFAULT 1,
  responsable VARCHAR(255),
  reporte VARCHAR(100),
  status VARCHAR(10),
  total DECIMAL(10,2) DEFAULT 0,
  costo DECIMAL(10,2) DEFAULT 0,
  utilidad DECIMAL(10,2) DEFAULT 0,
  factura VARCHAR(10) DEFAULT 'sin',
  numero_factura VARCHAR(100),
  guia VARCHAR(100),
  cobro VARCHAR(20) DEFAULT 'pendiente',
  fecha_factura DATE,
  dias_vencidos INT DEFAULT 0,
  created_by BIGINT REFERENCES usuarios(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== ENTREGAS (Por usuario + compartido) =====
CREATE TABLE entregas (
  id BIGINT PRIMARY KEY,
  fecha DATE NOT NULL,
  cliente VARCHAR(255),
  direccion TEXT,
  receptor VARCHAR(255),
  guia VARCHAR(100),
  notas TEXT,
  status VARCHAR(50),
  created_by BIGINT REFERENCES usuarios(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== FACTURAS (Auditoría completa) =====
CREATE TABLE facturas (
  id BIGINT PRIMARY KEY,
  numero VARCHAR(50),
  fecha DATE,
  cliente VARCHAR(255),
  total DECIMAL(10,2),
  costo DECIMAL(10,2),
  status VARCHAR(50),
  vendedor VARCHAR(255),
  created_by BIGINT REFERENCES usuarios(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===== ÍNDICES para búsquedas rápidas =====
CREATE INDEX idx_productos_sku ON productos(sku);
CREATE INDEX idx_productos_categoria ON productos(categoria);
CREATE INDEX idx_productos_created_by ON productos(created_by);
CREATE INDEX idx_clientes_nombre ON clientes(nombre);
CREATE INDEX idx_clientes_rfc ON clientes(rfc);
CREATE INDEX idx_clientes_created_by ON clientes(created_by);
CREATE INDEX idx_ventas_fecha ON ventas(fecha);
CREATE INDEX idx_ventas_cliente ON ventas(cliente);
CREATE INDEX idx_ventas_created_by ON ventas(created_by);
CREATE INDEX idx_entregas_fecha ON entregas(fecha);
CREATE INDEX idx_entregas_cliente ON entregas(cliente);
CREATE INDEX idx_entregas_created_by ON entregas(created_by);
CREATE INDEX idx_facturas_numero ON facturas(numero);
CREATE INDEX idx_facturas_created_by ON facturas(created_by);
CREATE INDEX idx_usuarios_usuario ON usuarios(usuario);

-- ===== ROW LEVEL SECURITY (RLS) - Todos pueden ver datos compartidos =====
-- Productos: todos pueden ver y crear
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_productos" ON productos FOR SELECT USING (true);
CREATE POLICY "usuarios_crear_productos" ON productos FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_actualizar_productos" ON productos FOR UPDATE USING (true);

-- Clientes: todos pueden ver y crear
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_clientes" ON clientes FOR SELECT USING (true);
CREATE POLICY "usuarios_crear_clientes" ON clientes FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_actualizar_clientes" ON clientes FOR UPDATE USING (true);

-- Ventas: todos pueden ver, crear propias
ALTER TABLE ventas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_ventas" ON ventas FOR SELECT USING (true);
CREATE POLICY "usuarios_crear_ventas" ON ventas FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_actualizar_ventas" ON ventas FOR UPDATE USING (true);

-- Entregas: todos pueden ver y crear
ALTER TABLE entregas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_entregas" ON entregas FOR SELECT USING (true);
CREATE POLICY "usuarios_crear_entregas" ON entregas FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_actualizar_entregas" ON entregas FOR UPDATE USING (true);

-- Facturas: todos pueden ver y crear
ALTER TABLE facturas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_facturas" ON facturas FOR SELECT USING (true);
CREATE POLICY "usuarios_crear_facturas" ON facturas FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_actualizar_facturas" ON facturas FOR UPDATE USING (true);

-- Usuarios: solo lectura (admin manage desde el app)
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;
CREATE POLICY "usuarios_ver_usuarios" ON usuarios FOR SELECT USING (true);

-- ===== INSERTS iniciales =====
INSERT INTO usuarios (id, usuario, pin, nombre, rol, activo)
VALUES (1, 'admin', '1234', 'Administrador', 'admin', true)
ON CONFLICT (id) DO NOTHING;
