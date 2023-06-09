--Exercice 3--

SELECT * FROM departements;
SELECT * FROM regions;
SELECT * FROM communes;

-- Question 1 --
SELECT pop FROM communes WHERE nom = 'Lyon';

--Question 2--

SELECT COUNT(*) FROM communes;

SELECT SUM(pop) FROM communes;

SELECT SUM(pop) / COUNT(*) FROM communes;

--Question 3--

SELECT nom,pop FROM communes ORDER BY pop DESC LIMIT 10;

--Questionb 4--

SELECT COUNT(*) FROM communes WHERE pop > 50000;

--Question 5--

SELECT COUNT(DISTINCT nom) FROM communes;

--Question 6--

SELECT * FROM communes WHERE pop < length(nom);

--Question 7--

SELECT communes.nom,communes.pop FROM communes 
JOIN departements ON departements.id = communes.dep
WHERE departements.nom = 'Meuse'
ORDER BY pop ASC LIMIT 10;

--Question 8--

SELECT departements.nom, COUNT(communes.nom) AS Nbville FROM departements 
JOIN communes ON communes.dep = departements.id
GROUP BY departements.nom
ORDER BY Nbville DESC;

--Question 9--

SELECT regions.nom, SUM(communes.pop) as Nbrpop FROM regions
JOIN departements ON departements.reg = regions.id
JOIN communes ON communes.dep = departements.id
GROUP BY regions.nom
ORDER BY Nbrpop DESC;

--Exercice 4--

--Question 1--

SELECT regions.nom, SUM(communes.pop) FROM regions
JOIN departements ON departements.reg = regions.id
JOIN communes ON communes.dep = departements.id
WHERE communes.pop < 100
GROUP BY regions.nom
ORDER BY SUM(communes.pop) DESC;

--Question 2--

SELECT nom FROM communes
GROUP BY nom
ORDER BY COUNT(*) DESC
LIMIT 1;