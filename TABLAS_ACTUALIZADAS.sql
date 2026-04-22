-- ========================================
-- MAYA AUTOPARTES - Tablas EXACTAS de app anterior
-- ========================================

DROP TABLE IF EXISTS facturas CASCADE;
DROP TABLE IF EXISTS entregas CASCADE;
DROP TABLE IF EXISTS ventas CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

-- ===== USUARIOS =====
CREATE TABLE usuarios (
  id BIGINT PRIMARY KEY,
  usuario VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  nombre VARCHAR(255),
  rol VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW()
);

-- ===== PRODUCTOS (ALMACÉN) =====
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
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ===== CLIENTES =====
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
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ===== VENTAS =====
CREATE TABLE ventas (
  id BIGINT PRIMARY KEY,
  fecha DATE NOT NULL,
  reporte VARCHAR(255),
  cliente VARCHAR(255),
  responsable VARCHAR(255),
  cantidad INT DEFAULT 1,
  status VARCHAR(100),
  factura VARCHAR(100),
  total DECIMAL(10,2) DEFAULT 0,
  costo DECIMAL(10,2) DEFAULT 0,
  guia VARCHAR(100),
  cobro VARCHAR(50),
  fechaFactura DATE,
  diasVencidos INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ===== ENTREGAS =====
CREATE TABLE entregas (
  id BIGINT PRIMARY KEY,
  fecha DATE NOT NULL,
  cliente VARCHAR(255),
  direccion TEXT,
  receptor VARCHAR(255),
  guia VARCHAR(100),
  notas TEXT,
  status VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ===== FACTURAS =====
CREATE TABLE facturas (
  id BIGINT PRIMARY KEY,
  numero VARCHAR(50),
  fecha DATE,
  cliente VARCHAR(255),
  total DECIMAL(10,2),
  status VARCHAR(50),
  vendedor VARCHAR(255),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Índices para búsquedas rápidas
CREATE INDEX idx_productos_sku ON productos(sku);
CREATE INDEX idx_productos_categoria ON productos(categoria);
CREATE INDEX idx_clientes_nombre ON clientes(nombre);
CREATE INDEX idx_clientes_rfc ON clientes(rfc);
CREATE INDEX idx_ventas_fecha ON ventas(fecha);
CREATE INDEX idx_ventas_cliente ON ventas(cliente);
CREATE INDEX idx_entregas_fecha ON entregas(fecha);
CREATE INDEX idx_entregas_cliente ON entregas(cliente);
CREATE INDEX idx_facturas_numero ON facturas(numero);
CREATE INDEX idx_usuarios_usuario ON usuarios(usuario);

-- Deshabilitar RLS para empezar (agregar después si necesitas)
ALTER TABLE usuarios DISABLE ROW LEVEL SECURITY;
ALTER TABLE productos DISABLE ROW LEVEL SECURITY;
ALTER TABLE clientes DISABLE ROW LEVEL SECURITY;
ALTER TABLE ventas DISABLE ROW LEVEL SECURITY;
ALTER TABLE entregas DISABLE ROW LEVEL SECURITY;
ALTER TABLE facturas DISABLE ROW LEVEL SECURITY;
