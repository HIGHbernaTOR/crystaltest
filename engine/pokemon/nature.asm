; Return a Pokémon's stored Nature.
;
; Input:
;   hl = address of the beginning of a Pokémon struct
;
; Output:
;   a  = Nature value
;   hl = address of the Pokémon's MON_NATURE byte
GetMonNature:
	ld bc, MON_NATURE
	add hl, bc
	ld a, [hl]
	ret
	
	
; Return a pointer to a Nature's effect entry.
;
; Input:
;   a = Nature ID
;
; Output:
;   hl = pointer into NatureEffects
;
GetNatureEffectPointer:
	ld l, a
	ld h, 0

	add hl, hl ; each entry is 2 bytes

	ld bc, NatureEffects
	add hl, bc

	ret
	
	
; Get the stat raised and lowered by a Nature.
;
; Input:
;   a = Nature ID
;
; Output:
;   b = raised stat
;   c = lowered stat
;
GetNatureStatModifiers:
	call GetNatureEffectPointer

	ld a, [hli]
	ld b, a

	ld a, [hl]
	ld c, a

	ret
	
; Get the raised and lowered stats for wTempMon's Nature.
;
; Output:
;   wStringBuffer2     = raised stat
;   wStringBuffer2 + 1 = lowered stat
GetTempMonNatureStatModifiers:
	ld a, [wTempMonNature]

	cp NUM_NATURES
	jr c, .valid
	xor a ; invalid Nature falls back to Hardy

.valid
	call GetNatureStatModifiers

	ld a, b
	ld [wStringBuffer2], a

	ld a, c
	ld [wStringBuffer2 + 1], a
	ret
	

; Copy the current temp Pokémon's Nature name to wStringBuffer1.
;
; Output:
;   de = wStringBuffer1
GetNatureName:
	ld a, [wTempMonNature]

	cp NUM_NATURES
	jr c, .valid
	xor a ; invalid Nature falls back to Hardy

.valid
	ld hl, NatureNames
	ld bc, MON_NAME_LENGTH - 1
	call AddNTimes

	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes

	ld de, wStringBuffer1
	ret
	
	
; Look up the Nature stored in wStringBuffer1.
;
; Input:
;   wStringBuffer1 = Nature ID
;
; Output:
;   wStringBuffer2     = raised stat
;   wStringBuffer2 + 1 = lowered stat
GetNatureModifiersFromBuffer:
	ld a, [wStringBuffer1]

	cp NUM_NATURES
	jr c, .valid
	xor a ; invalid Nature falls back to Hardy

.valid
	call GetNatureStatModifiers

	ld a, b
	ld [wStringBuffer2], a

	ld a, c
	ld [wStringBuffer2 + 1], a
	ret