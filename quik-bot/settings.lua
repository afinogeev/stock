settings = {}

-- QUIK --
settings.CLIENT_CODE = '649924'
settings.SECCODE = 'SBER'
settings.ACCOUNT  = 'L01+00000F00'
settings.FIRMID = 'MC0007400000'
settings.CLASSCODE = 'TQBR'

-- INDICATORS --
settings.chaikin_oscillator_tag = "SBERCHAIKIN"
settings.macdh_tag = "SBERMACDH"
settings.trix_tag = "SBERTRIX"
settings.stochastic_tag = "SBERSTOCHASTIC"
settings.bollinger_tag = "SBERBOLLINGER"
settings.price_tag = "SBERPRICE"
--

-- 
settings.interval = 1 -- minutes
settings.time_advance = 2 -- sec
settings.delta_price = 0.15
settings.commission = 0.00006
--

-- TRANSACTION --
settings.transaction = { TRANS_ID='1',
						ACTION='NEW_ORDER',
						CLASSCODE=settings.CLASSCODE,
						ACCOUNT=settings.ACCOUNT,
						CLIENT_CODE=settings.CLIENT_CODE,
						SECCODE=settings.SECCODE,
						OPERATION='S',
						PRICE='0.00',
						QUANTITY= '1',
						TYPE='M'}
--