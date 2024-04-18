--Realizar una transacción para agregar un nuevo jugador y actualizar la lista de goles de un equipo con los goles de ese jugador
BEGIN TRANSACTION

SELECT COUNT(*) AS NumeroJugadores FROM Futbolistas

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo, Posicion, Edad, Goles)
VALUES ('RC00084', 'Aitor Fernandez','#RCELTA', 'Portero',35, 20);

SELECT COUNT(*) AS NumeroJugadores FROM Futbolistas

SELECT Goles FROM Equipos
WHERE Codigo = '#RCELTA'

UPDATE Equipos
SET Goles = Goles + (SELECT Goles
FROM Futbolistas
WHERE Codigo = 'RC00084')
WHERE Codigo = (SELECT CodigoEquipo
FROM Futbolistas
WHERE Codigo = 'RC00084');

SELECT Goles FROM Equipos
WHERE Codigo = '#RCELTA'

COMMIT

--Realizar una transacción para mover a un jugador de un equipo y no restar la cantidad de goles ni sumársela al nuevo equipo.

BEGIN TRANSACTION

SELECT COUNT(*) AS NumJugadores
FROM Futbolistas
WHERE CodigoEquipo = '#GETAFE'

UPDATE Futbolistas
SET CodigoEquipo = '#GETAFE'
WHERE Codigo = 'RC00084'

SELECT COUNT(*) AS NumJugadores
FROM Futbolistas
WHERE CodigoEquipo = '#GETAFE'

SELECT Goles FROM Equipos
WHERE Codigo = '#GETAFE'

UPDATE Equipos
SET Goles = Goles + (SELECT Goles
FROM Futbolistas
WHERE Codigo = 'RC00084')
WHERE Codigo = (SELECT CodigoEquipo
FROM Futbolistas
WHERE Codigo = 'RC00084');

SELECT Goles FROM Equipos
WHERE Codigo = '#GETAFE'

COMMIT

--Realizar una transacción para agregar un nuevo equipo y agregar 2 jugadores nuevos a ese equipo.

BEGIN TRANSACTION

INSERT INTO Equipos (Codigo, Nombre, Pais)
VALUES ('#HERCULES', 'Hercules', 'España')

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo)
VALUES ('HER001', 'Lucía', '#HERCULES')

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo)
VALUES ('HER002', 'Eva', '#HERCULES')

SELECT * FROM Equipos
WHERE Codigo = '#HERCULES'

SELECT * FROM Futbolistas
WHERE CodigoEquipo = '#HERCULES'

COMMIT
