; Copy wTempMon's Characteristic text into wStringBuffer1.
;
; Characteristic categories:
;   0 = HP
;   1 = Attack
;   2 = Defense
;   3 = Speed
;   4 = Special Attack
;
; Crystal has one shared Special DV, so the Special Attack
; Characteristic group represents that DV.
;
; Ties are resolved using the Pokémon's Nature.
;
; Output:
;   de = wStringBuffer1
GetTempMonCharacteristic:
	call .GetHighestDVCategory
	; b = selected category, 0-4
	; c = highest DV, 0-15

	; Each category owns five Characteristic entries.
	ld a, b
	add a
	add a
	add b ; category * 5
	ld b, a

	; Add highest DV modulo 5.
	ld a, c
.characteristic_mod_five
	cp 5
	jr c, .got_remainder
	sub 5
	jr .characteristic_mod_five

.got_remainder
	add b
	; a = final Characteristic index, 0-24

	; Each pointer is two bytes.
	ld l, a
	ld h, 0
	add hl, hl

	ld bc, CharacteristicPointers
	add hl, bc

	; Read the selected pointer.
	ld e, [hl]
	inc hl
	ld d, [hl]

	; Copy the selected ROM string into WRAM before farcall returns.
	ld h, d
	ld l, e
	ld de, wStringBuffer1
	ld b, 2 ; copy two strings

.copy_string
	ld a, [hli]
	ld [de], a
	inc de
	cp CHARVAL("@")
	jr nz, .copy_string

	dec b
	jr nz, .copy_string

	ld de, wStringBuffer1
	ret
	
	
.GetHighestDVCategory:
; Extract the five DVs, find the maximum, and resolve ties.
;
; Output:
;   b = selected category, 0-4
;   c = selected/highest DV

	; Byte 1: Attack in upper nibble, Defense in lower nibble.
	ld a, [wTempMonDVs]
	ld d, a

	swap a
	and $f
	ld [wStringBuffer2 + 1], a ; Attack DV

	ld a, d
	and $f
	ld [wStringBuffer2 + 2], a ; Defense DV

	; Byte 2: Speed in upper nibble, Special in lower nibble.
	ld a, [wTempMonDVs + 1]
	ld d, a

	swap a
	and $f
	ld [wStringBuffer2 + 3], a ; Speed DV

	ld a, d
	and $f
	ld [wStringBuffer2 + 4], a ; Special DV

	; Derive HP DV from the low bit of each stored DV.
	call .GetHPDV
	ld [wStringBuffer2], a

	; Find the highest value.
	xor a
	ld c, a ; highest DV found so far
	ld b, a ; fallback category = HP

	ld hl, wStringBuffer2
	ld e, 0 ; current category

.find_highest
	ld a, [hli]
	cp c
	jr c, .next_category
	jr z, .next_category

	ld c, a
	ld b, e

.next_category
	inc e
	ld a, e
	cp 5
	jr nz, .find_highest

	; Resolve ties using Nature as the starting category.
	call .ResolveHighestDVTie
	ret
	
	
.GetHPDV:
; HP DV bits:
;   bit 3 = Attack DV bit 0
;   bit 2 = Defense DV bit 0
;   bit 1 = Speed DV bit 0
;   bit 0 = Special DV bit 0
;
; Output:
;   a = HP DV, 0-15

	xor a
	ld e, a

	ld a, [wStringBuffer2 + 1] ; Attack
	and 1
	jr z, .no_attack_bit
	set 3, e

.no_attack_bit
	ld a, [wStringBuffer2 + 2] ; Defense
	and 1
	jr z, .no_defense_bit
	set 2, e

.no_defense_bit
	ld a, [wStringBuffer2 + 3] ; Speed
	and 1
	jr z, .no_speed_bit
	set 1, e

.no_speed_bit
	ld a, [wStringBuffer2 + 4] ; Special
	and 1
	jr z, .done
	set 0, e

.done
	ld a, e
	ret
	
	
.ResolveHighestDVTie:
; Select the first category with the maximum DV, beginning at
; Nature modulo 5 and wrapping through all five categories.
;
; Input:
;   c = highest DV
;
; Output:
;   b = selected category

	ld a, [wTempMonNature]

	; Nature modulo 5 gives the starting category.
.nature_mod_five
	cp 5
	jr c, .got_start
	sub 5
	jr .nature_mod_five

.got_start
	ld e, a ; starting/current category
	ld d, 5 ; categories remaining

.check_category
	ld hl, wStringBuffer2
	ld a, e
	push de
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ld a, [hl]
	cp c
	jr z, .found

	inc e
	ld a, e
	cp 5
	jr c, .no_wrap
	xor a
	ld e, a

.no_wrap
	dec d
	jr nz, .check_category

	; Safety fallback.
	xor a
	ld b, a
	ret

.found
	ld b, e
	ret
	
	
