--Insertar un equipo de tu elecci�n con valores espec�ficos
  INSERT INTO Equipos (Codigo, Nombre, Pais, Estadio, Ciudad)
  VALUES ('#RMCAS', 'Real Madrid castilla','Espa�a', 'Alfredo Di St�fano', 'Madrid')

--Insertar varios jugadores de ese equipo (en la misma consulta)
  INSERT INTO Futbolistas (Codigo, Nombre, CodigoEquipo, Dorsal)
  VALUES
  ('#RMCAS001', 'Vinicius Tobias', '#RMCAS', 20),
  ('#RMCAS002', 'Nico Paz', '#RMCAS', 11)

--Insertar jugadores en una tabla utilizando una subconsulta
INSERT INTO FutbolistasSub25
SELECT CASE
WHEN CHARINDEX(' ',f.nombre) = 0 THEN f.Nombre
WHEN CHARINDEX(' ',f.nombre) > 0 THEN substring(f.Nombre,1,CHARINDEX(' ',f.nombre))
END AS Nombre,
CASE
WHEN CHARINDEX(' ',f.nombre) = 0 THEN ''
WHEN CHARINDEX(' ',f.nombre) > 0 THEN substring(f.Nombre,CHARINDEX(' ',f.nombre),LEN(f.Nombre))
END AS Apellido
FROM Futbolistas f
WHERE f.Edad < 25
--Insertar un equipo en una tabla utilizando la cl�usula �DEFAULT VALUES�
INSERT INTO Equipos
VALUES ('#CeltaFortuna', 'RC Celta Fortuna', 'Espa�a', DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT, DEFAULT, 'Bala�dos', 'Vigo')

--Guardar en la tabla FutbolistasEspanha todos los futbolistas que jueguen para equipos espa�oles y separar el nombre de apellido
INSERT INTO FutbolistasEspanha
SELECT CASE
WHEN CHARINDEX(' ',f.nombre) = 0 THEN f.Nombre
WHEN CHARINDEX(' ',f.nombre) > 0 THEN substring(f.Nombre,1,CHARINDEX(' ',f.nombre))
END AS Nombre,
CASE
WHEN CHARINDEX(' ',f.nombre) = 0 THEN ''
WHEN CHARINDEX(' ',f.nombre) > 0 THEN substring(f.Nombre,CHARINDEX(' ',f.nombre),LEN(f.Nombre))
END AS Apellido
FROM Futbolistas f
INNER JOIN Equipos e on f.CodigoEquipo = e.Codigo
WHERE e.Pais LIKE 'Espa�a'



