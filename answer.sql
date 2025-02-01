CREATE TABLE `libreriadigital`.`clientes` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `nombre` VARCHAR(100),
   `ciudad` VARCHAR(50),
   `correo` VARCHAR(75),
   `fecha_registro` DATE,
  PRIMARY KEY (`id`));
  
CREATE TABLE `libreriadigital`.`libros` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `titulo` VARCHAR(50),
   `autor` VARCHAR(100),
   `genero` VARCHAR(100),
   `precio` INT,
   `stock` INT,
   `editorial` VARCHAR(50),
  PRIMARY KEY (`id`));
  
CREATE TABLE `libreriadigital`.`pedidos` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `id_cliente` INT,
   `id_libro` INT,
   `cantidad` INT,
   `fecha_pedido` DATETIME,
   
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_cliente`)
  REFERENCES `libreriadigital`.`clientes` (`id`),
  FOREIGN KEY (`id_libro`)
  REFERENCES `libreriadigital`.`libros` (`id`)
);
  
INSERT INTO libreriadigital.libros (titulo, autor, genero, precio, stock, editorial) VALUES
('Cien anos de soledad', 'Gabriel Garcia Marquez', 'Realismo magico', 45000, 10, 'Sudamericana'),
('Rayuela', 'Julio Cortazar', 'Novela', 38000, 8, 'Sudamericana'),
('La casa de los espiritus', 'Isabel Allende', 'Ficcion historica', 42000, 6, 'Plaza & Janes'),
('Pedro Paramo', 'Juan Rulfo', 'Realismo magico', 29000, 4, 'Fondo de Cultura Economica'),
('Los detectives salvajes', 'Roberto Bolano', 'Novela', 46000, 7, 'Anagrama'),
('El tunel', 'Ernesto Sabato', 'Novela psicologica', 31000, 3, 'Seix Barral'),
('Ficciones', 'Jorge Luis Borges', 'Cuento', 35000, 9, 'Emece Editores'),
('Santa Evita', 'Tomas Eloy Martinez', 'Novela historica', 40000, 5, 'Alfaguara'),
('El Aleph', 'Jorge Luis Borges', 'Cuento', 33000, 2, 'Emece Editores'),
('La ciudad y los perros', 'Mario Vargas Llosa', 'Novela', 37000, 12, 'Seix Barral');

INSERT INTO libreriadigital.clientes (nombre, correo, ciudad, fecha_registro) VALUES
('Carlos Perez', 'carlos.perez@email.com', 'Bogota', '2023-10-12'),
('Mariana Lopez', 'mariana.lopez@email.com', 'Medellin', '2023-09-25'),
('Jorge Castillo', 'jorge.castillo@email.com', 'Cali', '2023-11-05'),
('Ana Ramirez', 'ana.ramirez@email.com', 'Barranquilla', '2023-08-18'),
('Sofia Gonzalez', 'sofia.gonzalez@email.com', 'Cartagena', '2024-01-15');

-- Insercion en pedidos
-- Tres pedidos del mismo cliente (Carlos Perez)
INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 1, 1, '2024-01-30'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 1 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1 
WHERE id = 1 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 5, 2, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 5 AND stock >= 2
);

UPDATE libreriadigital.libros 
SET stock = stock - 2
WHERE id = 5 AND stock >= 2;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 1, 7, 1, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 7 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 5 AND stock >= 1;

-- Dos pedidos en los ultimos 3 dias (hoy es 2024-01-29)
INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 2, 3, 1, '2024-01-27'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 3 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 3 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 3, 6, 1, '2024-01-28'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 6 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 6 AND stock >= 1;

-- Un cliente con multiples pedidos de diferentes libros
INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 4, 2, 1, '2024-01-25'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 2 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 2 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 4, 8, 2, '2024-01-26'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 8 AND stock >= 2
);

UPDATE libreriadigital.libros 
SET stock = stock - 2
WHERE id = 2 AND stock >= 2;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 5, 4, 1, '2024-01-21'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 4 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 4 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (id_cliente, id_libro, cantidad, fecha_pedido)
SELECT 2, 10, 1, '2024-01-23'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE id = 10 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE id = 10 AND stock >= 1;

-- Mostrar los pedidos realizados en el último mes.
SELECT * FROM libreriadigital.pedidos 
WHERE fecha_pedido <= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Mostrar los títulos de los libros cuyo stock sea menor a 5.
SELECT titulo FROM libreriadigital.libros WHERE stock < 5;

-- Listar los clientes junto con el número total de pedidos que han realizado. 
SELECT nombre, (SELECT COUNT(*) FROM libreriadigital.pedidos WHERE pedidos.id_cliente = clientes.id) AS Total_Pedidos FROM libreriadigital.clientes;

-- Obtener el libro más caro y el más barato de la librería.
SELECT titulo, precio FROM libreriadigital.libros ORDER BY precio DESC LIMIT 1;


SELECT titulo, precio FROM libreriadigital.libros ORDER BY precio ASC LIMIT 1;

-- Consultar los pedidos con más de 2 ejemplares de un mismo libro.
SELECT * FROM libreriadigital.pedidos WHERE cantidad >= 2;

-- Eliminar los pedidos que fueron hechos hace más de un año.
DELETE FROM libreriadigital.pedidos where fecha_pedido < YEAR(CURDATE());

-- Resetear la tabla de pedidos eliminando todos los datos, pero sin eliminar la estructura.
TRUNCATE libreriadigital.pedidos;
	
