USE TuristickaAgencija_DW
GO

--Napuniti dimenziju DimVrijeme

--pomocne varijable--------------------
DECLARE @StartDate DATETIME = '01/01/2016'
DECLARE @EndDate DATETIME = '12/31/2018'
DECLARE @Dan INT
DECLARE @Mjesec INT
DECLARE @Godina INT
DECLARE @YYYY NVARCHAR(4)
DECLARE @DD NVARCHAR(2)
DECLARE @MM NVARCHAR(2)

-- potrebno za tabelu-----------------
DECLARE @VrijemeKey NVARCHAR(8)
DECLARE @VrijemeAltKey DATETIME
DECLARE @NazivDana NVARCHAR(12)
DECLARE @NazivMjeseca NVARCHAR(10)
DECLARE @Kvartal INT


WHILE @StartDate <= @EndDate
BEGIN
	
	SET @Dan =DAY(@StartDate)
	SET @Mjesec =MONTH(@StartDate)
	SET @Godina =YEAR(@StartDate)
	------------------------------------

	IF(@Dan<10)
		SET @DD='0'+CONVERT(NVARCHAR(1),@Dan)
	ELSE
		SET @DD=CONVERT(NVARCHAR(2),@Dan)		

	IF(@Mjesec<10)
		SET @MM = '0'+CONVERT(NVARCHAR(1),@Mjesec)
	ELSE
		SET @MM =CONVERT(NVARCHAR(2),@Mjesec)

	
	SET @YYYY  =CONVERT(NVARCHAR(4),YEAR(@StartDate))
	--------------------------------------------------- podeseni MM DD YYYY

	SET @VrijemeKey =@YYYY+@MM+@DD		-- podesen primarni kljuc 19200101,19202107....
	SET @VrijemeAltKey=@StartDate		-- podesen datum za 
	SET @NazivDana = DATENAME(DW,@StartDate) -- podesen naziv dana Monday,Tuesday....
	SET @NazivMjeseca = DATENAME(MM,@StartDate) --podesen naziv mjeseca January, February...
	SET @Kvartal = DATEPART(QQ,@StartDate) --- podesen kvartal 1-4

	INSERT INTO dbo.DimVrijeme(VrijemeKey,VrijemeAltKey,Dan,Mjesec,Godina,NazivMjeseca,NazivDana,Kvartal)
	VALUES (@VrijemeKey, @VrijemeAltKey, @Dan,@Mjesec,@Godina,@NazivMjeseca,@NazivDana,@Kvartal)
	-- ubacivanje generisanog zapisa u tabelu
	
	SET @StartDate = DATEADD(DAY,1,@StartDate)
	--povecavanje dana za jedan na trenutnom datumu

END;


