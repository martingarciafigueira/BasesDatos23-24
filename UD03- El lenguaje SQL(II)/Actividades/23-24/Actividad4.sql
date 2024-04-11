
SELECT * FROM Futbolistas
SELECT * FROM Equipos

--Eliminar un jugador de un equipo.
DELETE FROM Futbolistas
WHERE Codigo = 'RM0023'

--Eliminar los equipos italianos.
DELETE FROM Equipos
WHERE Pais = 'Italia'

--Eliminar un equipo de La Liga, y por lo tanto, a todos sus jugadores.
DELETE FROM Equipos WHERE Codigo = '#ATHBIL'
DELETE FROM Futbolistas WHERE CodigoEquipo = '#ATHBIL'

--Eliminar a todos los porteros de los equipos.
DELETE FROM Futbolistas
WHERE Posicion LIKE 'Portero'

--Eliminar a todos los canteranos de los equipos (no tienen dorsal entre 1 y 25)
DELETE FROM Futbolistas
WHERE Dorsal > 25

--Eliminar a aquellos equipos que tengan menos de 23 jugadores (y, por supuesto, a sus jugadores)
DELETE FROM Equipos
WHERE Codigo IN (
SELECT CodigoEquipo
FROM Futbolistas
GROUP BY CodigoEquipo
HAVING COUNT(*) < 23 AND CodigoEquipo NOT LIKE 'RETIRADO')

DELETE FROM Futbolistas
WHERE CodigoEquipo IN (
SELECT CodigoEquipo
FROM Futbolistas
GROUP BY CodigoEquipo
HAVING COUNT(*) < 23 AND CodigoEquipo NOT LIKE 'RETIRADO')

--Eliminar a aquellos jugadores que se hayan retirado ( o pasen de 40 años)
DELETE FROM Futbolistas
WHERE CodigoEquipo LIKE 'RETIRADO' OR Dorsal = 0 OR Edad > 40
