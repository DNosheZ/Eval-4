-- Creación BD
CREATE DATABASE libreriadigital;
USE libreriadigital;

--Creación tablas
CREATE TABLE `clientes` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `nombre` VARCHAR(100),
   `ciudad` VARCHAR(50),
   `correo` VARCHAR(75) UNIQUE,
   `fecha_registro` DATE,
  PRIMARY KEY (`id`)
);

CREATE TABLE `libros` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `titulo` VARCHAR(50),
   `autor` VARCHAR(100),
   `genero` VARCHAR(100),
   `precio` INT,
   `stock` INT DEFAULT 10,
   `editorial` VARCHAR(50),
  PRIMARY KEY (`id`)
);

CREATE TABLE `pedidos` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `id_cliente` INT,
   `id_libro` INT,
   `cantidad` INT,
   `fecha_pedido` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`)
);
  
-- Inserción de Datos (Libros y Clientes)
INSERT INTO libros (titulo, autor, genero, precio, stock, editorial) VALUES
('Cien años de soledad', 'Gabriel García Márquez', 'Realismo mágico', 45000, 10, 'Sudamericana'),
('Rayuela', 'Julio Cortázar', 'Novela', 38000, 8, 'Sudamericana'),
('La casa de los espíritus', 'Isabel Allende', 'Ficción histórica', 42000, 6, 'Plaza & Janés'),
('Pedro Páramo', 'Juan Rulfo', 'Realismo mágico', 29000, 4, 'Fondo de Cultura Económica'),
('Los detectives salvajes', 'Roberto Bolaño', 'Novela', 46000, 7, 'Anagrama'),
('El túnel', 'Ernesto Sábato', 'Novela psicológica', 31000, 3, 'Seix Barral'),
('Ficciones', 'Jorge Luis Borges', 'Cuento', 35000, 9, 'Emecé Editores'),
('Santa Evita', 'Tomás Eloy Martínez', 'Novela histórica', 40000, 5, 'Alfaguara'),
('El Aleph', 'Jorge Luis Borges', 'Cuento', 33000, 2, 'Emecé Editores'),
('La ciudad y los perros', 'Mario Vargas Llosa', 'Novela', 37000, 12, 'Seix Barral');

INSERT INTO clientes (nombre, correo, ciudad, fecha_registro) VALUES
('Carlos Pérez', 'carlos.perez@email.com', 'Bogotá', '2023-10-12'),
('Mariana López', 'mariana.lopez@email.com', 'Medellín', '2023-09-25'),
('Jorge Castillo', 'jorge.castillo@email.com', 'Cali', '2023-11-05'),
('Ana Ramírez', 'ana.ramirez@email.com', 'Barranquilla', '2023-08-18'),
('Sofía González', 'sofia.gonzalez@email.com', 'Cartagena', '2024-01-15');
('Sofia Gonzalez', 'sofia.gonzalez@email.com', 'Cartagena', '2024-01-15');

-- INSERCIÓN DE PEDIDOS Y ACTUALIZACIÓN

-- Tres pedidos del mismo cliente (Carlos Perez)
INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 1, 1, '2024-01-30'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 1 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1 
WHERE id = 1 AND stock >= 1;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 5, 2, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 5 AND stock >= 2
);

UPDATE libros 
SET stock = stock - 2
WHERE id = 5 AND stock >= 2;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 7, 1, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 7 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 5 AND stock >= 1;

-- Dos pedidos en los ultimos 3 dias (hoy es 2024-01-29)
INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 2, 3, 1, '2024-01-27'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 3 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 3 AND stock >= 1;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 3, 6, 1, '2024-01-28'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 6 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 6 AND stock >= 1;

-- Un cliente con multiples pedidos de diferentes libros
INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 4, 2, 1, '2024-01-25'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 2 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 2 AND stock >= 1;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 4, 8, 2, '2024-01-26'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 8 AND stock >= 2
);

UPDATE libros 
SET stock = stock - 2
WHERE id = 2 AND stock >= 2;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 5, 4, 1, '2024-01-21'
WHERE EXISTS (
    SELECT 1 FROM libros WHERE id = 4 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 4 AND stock >= 1;

INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 2, 10, 1, '2024-01-23'
WHERE EXISTS (
    SELECT 1 FROM llibros WHERE id = 10 AND stock >= 1
);

UPDATE libros 
SET stock = stock - 1
WHERE id = 10 AND stock >= 1;

-- Cliente 3 compra 4 ejemplares de un libro
INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 3, 2, 4, '2024-01-27' WHERE EXISTS (SELECT 1 FROM libros WHERE id = 2 AND stock >= 4);
UPDATE libros SET stock = stock - 4 WHERE id = 2 AND stock >= 4;

-- Cliente 4 compra 3 ejemplares de otro libro
INSERT INTO pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 4, 6, 3, '2024-01-28' WHERE EXISTS (SELECT 1 FROM libros WHERE id = 6 AND stock >= 3);
UPDATE libros SET stock = stock - 3 WHERE id = 6 AND stock >= 3;


-- CONSULTAS

-- Mostrar los pedidos realizados en el último mes.
SELECT * FROM pedidos WHERE fecha_pedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
-- Mostrar los títulos de los libros cuyo stock sea menor a 5.
SELECT titulo FROM libros WHERE stock < 5;

-- Listar los clientes junto con el número total de pedidos que han realizado. 
SELECT nombre, (SELECT COUNT(*) FROM libreriadigital.pedidos WHERE pedidos.id_cliente = clientes.id) AS Total_Pedidos FROM libreriadigital.clientes;

-- Obtener el libro más caro y el más barato de la librería.
SELECT titulo, precio FROM libros ORDER BY precio DESC LIMIT 1;
SELECT titulo, precio FROM libros ORDER BY precio ASC LIMIT 1;

-- Consultar los pedidos con más de 2 ejemplares de un mismo libro.
SELECT * FROM pedidos WHERE cantidad > 2;

-- Eliminar los pedidos que fueron hechos hace más de un año.
DELETE FROM pedidos where fecha_pedido < YEAR(CURDATE());

-- Resetear la tabla de pedidos eliminando todos los datos, pero sin eliminar la estructura.
TRUNCATE TABLE pedidos;
	
