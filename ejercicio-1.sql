/*
 ==================================================================
 EJERCICIO EN TABLA LIBROS
 ==================================================================
 */
-- Obtener todos los libros escritos por autores que cuenten con un seudónimo.
SELECT
    *
FROM
    tbl_libros
WHERE
    ID_AUTOR IN(
        SELECT
            ID_AUTOR
        FROM
            tbl_autores
        WHERE
            SEUDONIMO IS NOT NULL
    );

-- Obtener el título de todos los libros publicados en el año actual cuyos autores poseen un pseudónimo
SELECT
    TITULO
FROM
    tbl_libros
WHERE
    YEAR(CURDATE()) = YEAR(FECHA_PUBLICACION)
    and ID_AUTOR IN(
        SELECT
            ID_AUTOR
        FROM
            tbl_autores
        WHERE
            SEUDONIMO IS NOT NULL
    );

-- Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965.
SELECT
    *
FROM
    tbl_autores
WHERE
    ID_AUTOR IN(
        SELECT
            ID_AUTOR
        FROM
            tbl_autores
        WHERE
            SEUDONIMO IS NOT NULL
    )
    and YEAR(FECHA_NACIMIENTO) < 1965;

-- Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000.
UPDATE
    tbl_libros
SET
    DESCRIPCION = 'no disponible'
WHERE
    YEAR(FECHA_PUBLICACION) < 2000;

-- Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible.
SELECT
    ID_LIBRO
FROM
    tbl_libros
WHERE
    DESCRIPCION != 'no disponible'
    or DESCRIPCION IS NULL;

-- Obtener el título de los últimos 3 libros escritos por el autor con id 2.
SELECT
    TITULO
FROM
    tbl_libros
WHERE
    ID_AUTOR = 2
ORDER BY
    FECHA_PUBLICACION DESC
LIMIT
    3;

-- Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo.
SELECT
    (
        SELECT
            COUNT(ID_AUTOR)
        FROM
            tbl_libros
        WHERE
            ID_AUTOR IN(
                SELECT
                    ID_AUTOR
                FROM
                    tbl_autores
                WHERE
                    SEUDONIMO IS NULL
            )
    ) AS SIN_SEUDONIMO,
    (
        SELECT
            COUNT(ID_AUTOR)
        FROM
            tbl_libros
        WHERE
            ID_AUTOR IN(
                SELECT
                    ID_AUTOR
                FROM
                    tbl_autores
                WHERE
                    SEUDONIMO IS NOT NULL
            )
    ) AS CON_SEUDONIMO;

--  Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005.
SELECT
    *
FROM
    tbl_libros
WHERE
    YEAR(FECHA_PUBLICACION) BETWEEN 2000
    AND 2005;

-- Obtener el título y el número de ventas de los cinco libros más vendidos.
SELECT
    TITULO,
    VENTAS
FROM
    tbl_libros
ORDER BY
    ventas DESC
LIMIT
    5;

-- Obtener el título y el número de ventas de los cinco libros más vendidos de la última década.
SELECT
    TITULO,
    VENTAS,
    YEAR(FECHA_PUBLICACION) AS AÑO
FROM
    tbl_libros
WHERE
    -- (YEAR(CURDATE()) - YEAR(FECHA_PUBLICACION)) < 10
    YEAR(FECHA_PUBLICACION) BETWEEN '2010'
    AND '2020'
ORDER BY
    ventas DESC
LIMIT
    5;

-- Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3.
SELECT
    ID_AUTOR,
    SUM(VENTAS) AS LIBROS_VENDIDOS
FROM
    tbl_libros
GROUP BY
    ID_AUTOR
HAVING
    ID_AUTOR IN(1, 2, 3);

-- Obtener el título del libro con más páginas.
SELECT
    TITULO
FROM
    tbl_libros
ORDER BY
    PAGINAS DESC
LIMIT
    1;

-- Obtener todos los libros cuyo título comience con la palabra “La”.
SELECT
    *
FROM
    tbl_libros
WHERE
    TITULO LIKE 'la%';

-- Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”.
SELECT
    *
FROM
    tbl_libros
WHERE
    TITULO LIKE 'la%a';

-- Establecer el stock en cero a todos los libros publicados antes del año de 1995
UPDATE
    tbl_libros
SET
    STOCK = 0
WHERE
    year(FECHA_PUBLICACION) < 1995;

-- Mostrar el mensaje Disponible si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje No disponible.
SELECT
    IF(
        (
            SELECT
                STOCK
            FROM
                tbl_libros
            WHERE
                ID_LIBRO = 1
        ) > 5,
        'Disponible',
        'No Disponible'
    ) AS STOCK;

-- Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo.
SELECT
    TITULO
FROM
    tbl_libros
ORDER BY
    FECHA_PUBLICACION DESC;

/*
 ==================================================================
 EJERCICIO EN TABLA AUTORES
 ==================================================================
 */
-- Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950
SELECT
    NOMBRE
FROM
    tbl_autores
WHERE
    YEAR(FECHA_NACIMIENTO) < 1950;

-- Obtener la el nombre completo y la edad de todos los autores.
SELECT
    CONCAT(NOMBRE, ' ', APELLIDO) AS NOMBRE_COMPLETO,
    (YEAR(CURDATE()) - YEAR(FECHA_NACIMIENTO)) AS EDAD
FROM
    tbl_autores;

-- Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005
SELECT
    CONCAT(NOMBRE, ' ', APELLIDO) AS NOMBRE_COMPLETO
FROM
    tbl_autores
WHERE
    ID_AUTOR IN (
        SELECT
            DISTINCT ID_AUTOR
        FROM
            tbl_libros
        WHERE
            YEAR(FECHA_PUBLICACION) < 2005
    );

-- Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio.
-- *******************************REVISAR*******************************
SELECT
    DISTINCT ID_AUTOR
FROM
    tbl_libros
WHERE
    VENTAS > (
        SELECT
            ROUND(AVG(VENTAS))
        FROM
            tbl_libros
    );

-- Obtener el id de todos los escritores cuyas ventas en sus libros sean mayores a cien mil ejemplares.
SELECT
    DISTINCT ID_AUTOR,
    VENTAS
FROM
    tbl_libros
WHERE
    VENTAS > 100000;

/*
 ==================================================================
 EJERCICIO FUNCIONES
 ==================================================================
 */
-- Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible” si el libro posee por lo menos un ejemplar en stock, en caso contrario retornar “No disponible.”

DROP FUNCTION IF EXISTS COMPROBAR_STOCK;

DELIMITER // 

CREATE FUNCTION COMPROBAR_STOCK(ID INT) RETURNS CHAR(100) CHARACTER set utf8 BEGIN 
    RETURN (
        SELECT
            IF(STOCK = 0, 'No disponible', 'Disponible')
        FROM
            tbl_libros
        WHERE
            ID_LIBRO = ID
    );
END// 

DELIMITER ;

SELECT COMPROBAR_STOCK(1), COMPROBAR_STOCK(15);