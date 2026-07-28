CharacteristicPointers:

; HP
	dw CharacteristicStrings.LovesToEat
	dw CharacteristicStrings.TakesPlentyOfSiestas
	dw CharacteristicStrings.NodsOffALot
	dw CharacteristicStrings.ScattersThingsOften
	dw CharacteristicStrings.LikesToRelax

; Attack
	dw CharacteristicStrings.ProudOfItsPower
	dw CharacteristicStrings.LikesToThrashAbout
	dw CharacteristicStrings.ALittleQuickTempered
	dw CharacteristicStrings.LikesToFight
	dw CharacteristicStrings.QuickTempered

; Defense
	dw CharacteristicStrings.SturdyBody
	dw CharacteristicStrings.CapableOfTakingHits
	dw CharacteristicStrings.HighlyPersistent
	dw CharacteristicStrings.GoodEndurance
	dw CharacteristicStrings.GoodPerseverance

; Speed
	dw CharacteristicStrings.LikesToRun
	dw CharacteristicStrings.AlertToSounds
	dw CharacteristicStrings.ImpetuousAndSilly
	dw CharacteristicStrings.SomewhatOfAClown
	dw CharacteristicStrings.QuickToFlee

; Special Attack
	dw CharacteristicStrings.HighlyCurious
	dw CharacteristicStrings.Mischievous
	dw CharacteristicStrings.ThoroughlyCunning
	dw CharacteristicStrings.OftenLostInThought
	dw CharacteristicStrings.VeryFinicky

; Special Defense
	dw CharacteristicStrings.StrongWilled
	dw CharacteristicStrings.SomewhatVain
	dw CharacteristicStrings.StronglyDefiant
	dw CharacteristicStrings.HatesToLose
	dw CharacteristicStrings.SomewhatStubborn


CharacteristicStrings:

; HP
.LovesToEat:
	db "LOVES TO EAT@"
	db CHARVAL("@")

.TakesPlentyOfSiestas:
	db   "TAKES PLENTY OF@"
	db   "SIESTAS@"

.NodsOffALot:
	db "NODS OFF A LOT@"
	db CHARVAL("@")

.ScattersThingsOften:
	db   "SCATTERS THINGS@"
	db   "OFTEN@"

.LikesToRelax:
	db "LIKES TO RELAX@"
	db CHARVAL("@")


; Attack
.ProudOfItsPower:
	db   "PROUD OF ITS@"
	db   "POWER@"

.LikesToThrashAbout:
	db   "LIKES TO THRASH@"
	db   "ABOUT@"

.ALittleQuickTempered:
	db   "A LITTLE QUICK@"
	db   "TEMPERED@"

.LikesToFight:
	db "LIKES TO FIGHT@"
	db CHARVAL("@")

.QuickTempered:
	db "QUICK TEMPERED@"
	db CHARVAL("@")


; Defense
.SturdyBody:
	db "STURDY BODY@"
	db CHARVAL("@")

.CapableOfTakingHits:
	db   "CAPABLE OF@"
	db   "TAKING HITS@"

.HighlyPersistent:
	db "HIGHLY PERSISTENT@"
	db CHARVAL("@")

.GoodEndurance:
	db "GOOD ENDURANCE@"
	db CHARVAL("@")

.GoodPerseverance:
	db   "GOOD@"
	db   "PERSEVERANCE@"


; Speed
.LikesToRun:
	db "LIKES TO RUN@"
	db CHARVAL("@")

.AlertToSounds:
	db "ALERT TO SOUNDS@"
	db CHARVAL("@")

.ImpetuousAndSilly:
	db   "IMPETUOUS AND@"
	db   "SILLY@"

.SomewhatOfAClown:
	db   "SOMEWHAT OF A@"
	db   "CLOWN@"

.QuickToFlee:
	db "QUICK TO FLEE@"
	db CHARVAL("@")


; Special Attack
.HighlyCurious:
	db "HIGHLY CURIOUS@"
	db CHARVAL("@")

.Mischievous:
	db "MISCHIEVOUS@"
	db CHARVAL("@")

.ThoroughlyCunning:
	db   "THOROUGHLY@"
	db   "CUNNING@"

.OftenLostInThought:
	db   "OFTEN LOST IN@"
	db   "THOUGHT@"

.VeryFinicky:
	db "VERY FINICKY@"
	db CHARVAL("@")


; Special Defense
.StrongWilled:
	db "STRONG WILLED@"
	db CHARVAL("@")

.SomewhatVain:
	db "SOMEWHAT VAIN@"
	db CHARVAL("@")

.StronglyDefiant:
	db "STRONGLY DEFIANT@"
	db CHARVAL("@")

.HatesToLose:
	db "HATES TO LOSE@"
	db CHARVAL("@")

.SomewhatStubborn:
	db   "SOMEWHAT@"
	db   "STUBBORN@"