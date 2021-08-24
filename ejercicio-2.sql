-- Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días.
    -- Codigo para probar el ejercicio
    UPDATE tbl_libros_usuarios SET FECHA_CREACION = (FECHA_CREACION - INTERVAL 15 DAY) WHERE ID_USUARIO = 3;

SELECT DISTINCT
    tbl_libros_usuarios.ID_USUARIO,
    CONCAT(tbl_usuarios.NOMBRE, ' ', tbl_usuarios.APELLIDO) AS NOMBRE_COMPLETO,
    tbl_libros_usuarios.FECHA_CREACION AS FECHA_PRESTAMO_CREADO
FROM
    tbl_libros_usuarios
INNER JOIN tbl_usuarios ON 
        tbl_libros_usuarios.ID_USUARIO = tbl_usuarios.ID_USUARIO AND 
        tbl_libros_usuarios.FECHA_CREACION >= CURDATE() - INTERVAL 10 DAY;

-- Obtener a todos los usuarios que no ha realizado ningún préstamo.
SELECT DISTINCT
    ID_USUARIO,
    CONCAT(NOMBRE, ' ', APELLIDO) AS NOMBRE_COMPLETO
FROM
    tbl_usuarios
WHERE
    ID_USUARIO NOT IN (
        SELECT DISTINCT ID_USUARIO FROM tbl_libros_usuarios
    ) ;

-- Listar de forma descendente a los cinco usuarios con más préstamos.
SELECT 
    ID_USUARIO,
    CONCAT(NOMBRE,' ',APELLIDO) AS NOMBRE_COMPLETO,
    COUNT(ID_LIBRO) AS CANTIDAD_LIBROS 
FROM 
    tbl_libros_usuarios
LEFT JOIN tbl_usuarios USING(ID_USUARIO)
GROUP BY ID_USUARIO
ORDER BY CANTIDAD_LIBROS DESC
LIMIT 5;

-- Listar 5 títulos con más préstamos en los últimos 30 días.
SELECT
    tbl_libros.ID_LIBRO,
    tbl_libros.TITULO AS TITULO_LIBRO,
    COUNT(tbl_libros_usuarios.ID_LIBRO) AS CANTIDAD_PRESTADA
FROM
    tbl_libros_usuarios
LEFT JOIN tbl_libros ON
    tbl_libros_usuarios.ID_LIBRO = tbl_libros.ID_LIBRO AND
    tbl_libros_usuarios.FECHA_CREACION >= CURDATE() - INTERVAL 30 DAY
GROUP BY ID_LIBRO
ORDER BY CANTIDAD_PRESTADA DESC
LIMIT 5;

-- Obtener el título de todos los libros que no han sido prestados.
SELECT 
    TITULO
FROM
    tbl_libros
WHERE
    ID_LIBRO NOT IN(
        SELECT ID_LIBRO FROM tbl_libros_usuarios
    );

-- Obtener la cantidad de libros prestados el día de hoy.
SELECT
    COUNT(ID_LIBRO) AS CANTIDAD_PRESTADA_HOY
FROM
    tbl_libros_usuarios
WHERE
    FECHA_CREACION >= CURDATE();

-- Obtener la cantidad de libros prestados por el autor con id 1.
SELECT
    COUNT(ID_LIBRO) AS CANTIDAD_PRESTADA
FROM
    tbl_libros_usuarios
WHERE
    ID_USUARIO = 1;

-- Obtener el nombre completo de los cinco autores con más préstamos.
SELECT
    CONCAT(tbl_autores.NOMBRE,' ',tbl_autores.APELLIDO) AS AUTOR,
    COUNT(tbl_libros_usuarios.ID_LIBRO) AS CANTIDAD_PRESTADA
FROM
    tbl_libros_usuarios
INNER JOIN tbl_libros ON tbl_libros.ID_LIBRO = tbl_libros_usuarios.ID_LIBRO
INNER JOIN tbl_autores ON tbl_libros.ID_AUTOR = tbl_autores.ID_AUTOR
GROUP BY AUTOR
ORDER by CANTIDAD_PRESTADA DESC
LIMIT 5;

-- Obtener el título del libro con más préstamos esta semana.
SELECT
    tbl_libros.TITULO,
    count(tbl_libros_usuarios.ID_LIBRO) AS CANTIDAD_PRESTADA
FROM
    tbl_libros_usuarios
INNER JOIN tbl_libros ON 
    tbl_libros.ID_LIBRO = tbl_libros_usuarios.ID_LIBRO AND
    tbl_libros_usuarios.FECHA_CREACION >= CURDATE() - INTERVAL 10 DAY
GROUP BY TITULO
ORDER BY CANTIDAD_PRESTADA DESC
LIMIT 1;