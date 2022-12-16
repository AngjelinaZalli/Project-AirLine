---Function
---afisho idRregjistrimit,Emrin,Mbiemrin dhe Llojin e Biletes te pasagjerit me Llojbilete kategori VIP
---dhe Lloji bagazhit Luggage
CREATE FUNCTION IDRregjistrimi (@llojiBilete VARCHAR (50),@llojiBagazhit VARCHAR (50))
RETURNS TABLE
AS
RETURN (
SELECT IDRregjistrimi,p.Emer,P.Mbiemri,LlojiBiletes
FROM Pasagjer p INNER JOIN Bilete b
ON p.Id_P=b.Id_P
WHERE LlojiBiletes=@llojiBilete AND LlojiBagazhit=@llojiBagazhit
);
GO

SELECT * FROM IDRregjistrimi('VIP','Luggage');
DROP FUNCTION IDRregjistrimi

--Krijimi I funksionit IDRregjistrimi I cili merr dy parametra @llojiBilete dhe @llojiBagazhit te tipit varchar(50) .
--Funksioni do te kthej nje tabele.Kjo tabele do te permbaje atributet IDRregjistrimi,p.Emer,P.Mbiemri,LlojiBiletes nga te dyja tabelat,
--per kete perdorim nje inner join .
--Si perfundim ekzekutojme funksionin duke i dhene vete parametrat.

--Procedure
--Kthe emer Linje fluturimi,emer Avioni per avionin qe ka  harxhimin me te madh per 100km
CREATE PROCEDURE linjefluturimi1 (@Emer_Linjefluturimi VARCHAR(50) OUT,@Emer_Avioni VARCHAR(50) OUT,@Harxhim_Max INT OUT)
AS
BEGIN
SELECT @Emer_Linjefluturimi=l.Emer ,@Emer_Avioni=a.Emer,@Harxhim_Max=Harxhimper100KM
FROM Avion a INNER JOIN LinjeFluturimi l
ON a.Id_L=l.Id_L
WHERE Harxhimper100KM=(SELECT MAX(Harxhimper100KM) 
                       FROM Avion )
END

DECLARE @Emer_Linjefluturimi AS VARCHAR(50) ;
DECLARE @Emer_Avioni AS VARCHAR(50) ;
DECLARE @Harxhim_Max AS INT ;
EXECUTE linjefluturimi1 @Emer_Linjefluturimi=@Emer_Linjefluturimi OUT,@Emer_Avioni=@Emer_Avioni OUT,@Harxhim_Max=@Harxhim_Max OUT;
SELECT @Emer_Linjefluturimi AS LinjeFluturimi,@Emer_Avioni AS Avion,@Harxhim_Max AS Harxhimper100KM

DROP PROCEDURE linjefluturimi1

-- Krijimi I nje procedure qe kthen emrin e Linjes se fluturimit,emrin e  Avionit per avionin qe ka  harxhimin me te madh per 100km.
--Kjo procedure merr tre parmetra dales @Emer_Linjefluturimi dhe @Emer_Avioni te tipit varchar (50),@Harxhim_Max i tipit int.
--Me ane te nje subquery gjejme harxhimin max per 100km per cdo avion,me pas duke perdorur inner join bejme lidhjen e tabelave Avion
--dhe LinjeFluturimi per te gjetur se kujt linje fluturimi i perket avioni me harxhim max.
--Ne perfundim ekzekutojme proceduren duke deklaruar si fillim parametrat dales e ekzekutuar komanden exec
--Trigger
--Mos shtoni pilot ne databaze nqs jane me te vegjel se 27 vjec
CREATE TRIGGER MOS_SHTO_PILOT
ON Pilot
AFTER INSERT
AS BEGIN
DECLARE @datelindje DATE
SELECT @datelindje=Datelindje FROM inserted
IF(@Datelindje>'1995-01-01')
BEGIN
PRINT('NUK MUND TE SHTONI PILOT ME TE VEGJEL SE VITI 1995')
ROLLBACK;
END
ELSE 
PRINT('Piloti u shtua')
END;

INSERT INTO Pilot
VALUES('K16010102P','Edi','Prifti','M','2000-01-01','Ediprifti@gmail.com','0685545667','1','01','001');

DROP TRIGGER MOS_SHTO_PILOT;

--Triggeri i ndertuar krijohet mbi tabelen Pilot dhe aktivizohet pas perpjekjes per te shtuar pilot.Marrim datelindjen nga 
--tabela inserted dhe e krahasojme nqs eshte me i madh sesa datelindja e vene kusht nga ne,nqs po afishojme nje mesazh dhe 
--i bejme rollback inserted,ne te kundert shtojme pilotin dhe afishojme nje ms tjeter.
--Per te aktivizuar triggerin bejme nje insert me datelindje me te vogel
--Mesazhi i afishuar:
--NUK MUND TE SHTONI PILOT ME TE VEGJEL SE VITI 1995
--The transaction ended in the trigger. The batch has been aborted.
