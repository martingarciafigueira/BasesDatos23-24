--Realizar una transacción para agregar un nuevo jugador y actualizar la lista de goles de un equipo con los goles de ese jugador

BEGIN TRANSACTION

SELECT * FROM Futbolistas

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo, Goles)
VALUES ('RC0025', 'Diego Maradona', '#RCELTA', 78)

UPDATE Equipos
SET Goles += (SELECT Goles FROM Futbolistas WHERE Codigo = 'RC0025')
WHERE Codigo = (SELECT CodigoEquipo FROM Futbolistas WHERE Codigo = 'RC0025')

COMMIT TRANSACTION;

--Realizar una transacción para mover a un jugador de un equipo y no restar la cantidad de goles pero sí sumársela al nuevo equipo.

BEGIN TRANSACTION

UPDATE Futbolistas
SET CodigoEquipo = '#SVILLA'
WHERE Codigo = 'RC0025'

UPDATE Equipos
SET Goles += (SELECT Goles FROM Futbolistas WHERE Codigo = 'RC0025')
WHERE Codigo = (SELECT CodigoEquipo FROM Futbolistas WHERE Codigo = 'RC0025')

COMMIT TRANSACTION;

--Realizar una transacción para agregar un nuevo equipo y agregar 2 jugadores nuevos a ese equipo.

BEGIN TRANSACTION

INSERT INTO Equipos (Codigo, Nombre)
VALUES ('#MCST', 'Montecastelo')

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo, Goles)
VALUES ('MCST01', 'Tacio', '#MCST', 1)

INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo, Goles)
VALUES ('MCST02', 'Dani', '#MCST', 2)

COMMIT TRANSACTION;