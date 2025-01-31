CREATE TABLE `libreriadigital`.`clientes` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
   `nombre` VARCHAR(100),
   `ciudad` VARCHAR(50),
   `correo` VARCHAR(75),
   `fecha_registro` DATE,
  PRIMARY KEY (`idc`));
  
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
  REFERENCES `libreriadigital`.`libros` (`id_libro`)
);
  
  
INSERT INTO libreriadigital.libros (titulo, autor, genero, precio, stock, editorial) VALUES
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


INSERT INTO libreriadigital.clientes (nombre, correo, ciudad, fecha_registro) VALUES
('Carlos Pérez', 'carlos.perez@email.com', 'Bogotá', '2023-10-12'),
('Mariana López', 'mariana.lopez@email.com', 'Medellín', '2023-09-25'),
('Jorge Castillo', 'jorge.castillo@email.com', 'Cali', '2023-11-05'),
('Ana Ramírez', 'ana.ramirez@email.com', 'Barranquilla', '2023-08-18'),
('Sofía González', 'sofia.gonzalez@email.com', 'Cartagena', '2024-01-15');

-- insercion en pedidos
-- Tres pedidos del mismo cliente (Carlos Pérez)
INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 1, 1, 1, '2024-01-30'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 1 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1 
WHERE ID = 1 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 1, 5, 2, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 5 AND stock >= 2
);

UPDATE libreriadigital.libros 
SET stock = stock - 2
WHERE ID = 5 AND stock >= 2;

INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 1, 7, 1, '2024-01-22'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 7 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 5 AND stock >= 1;

-- Dos pedidos en los últimos 3 días (hoy es 2024-01-29)
INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 2, 3, 1, '2024-01-27'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 3 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 3 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 3, 6, 1, '2024-01-28'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 6 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 6 AND stock >= 1;

-- Un cliente con múltiples pedidos de diferentes libros
INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 4, 2, 1, '2024-01-25'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 2 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 2 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 4, 8, 2, '2024-01-26'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 8 AND stock >= 2
);

UPDATE libreriadigital.libros 
SET stock = stock - 2
WHERE ID = 2 AND stock >= 2;


INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 5, 4, 1, '2024-01-21'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 4 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 4 AND stock >= 1;

INSERT INTO libreriadigital.pedidos (ID_Cliente, ID_Libro, cantidad, fecha_pedido)
SELECT 2, 10, 1, '2024-01-23'
WHERE EXISTS (
    SELECT 1 FROM libreriadigital.libros WHERE ID = 10 AND stock >= 1
);

UPDATE libreriadigital.libros 
SET stock = stock - 1
WHERE ID = 10 AND stock >= 1;


SELECT * FROM libreriadigital.libros where autor='Ernesto Sabato' ORDER BY precio ASC;
	