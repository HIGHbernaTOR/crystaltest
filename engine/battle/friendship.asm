CheckFriendshipBonusChance::
	; Disable friendship bonuses in link battles.
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wBattleMonHappiness]

	ld b, 25 percent + 1
	cp 255
	jr z, .roll

	ld b, 18 percent + 1
	cp 220
	jr nc, .roll

	ld b, 12 percent + 1
	cp 180
	jr nc, .roll

	; Failure: return with carry clear.
	and a
	ret

.roll
	call BattleRandom
	cp b
	ret nc

	; Success: return with carry set.
	scf
	ret
	

CheckFriendshipConfusionRecovery::
	; The Pokémon must currently be confused.
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_CONFUSED, [hl]
	ret z

	call CheckFriendshipBonusChance
	ret nc

	; Remove confusion and clear its turn counter.
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ld [wPlayerConfuseCount], a

	ld hl, FriendshipCuredConfusionText
	jp StdBattleTextbox
	

CheckFriendshipAttractRecovery::
	; The player's Pokémon must currently be infatuated.
	ld hl, wPlayerSubStatus1
	bit SUBSTATUS_IN_LOVE, [hl]
	ret z

	; Use the shared friendship thresholds and activation chances.
	call CheckFriendshipBonusChance
	ret nc

	; Remove infatuation.
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_IN_LOVE, [hl]

	ld hl, FriendshipCuredAttractText
	jp StdBattleTextbox

	
CheckFriendshipDodge::
	; Friendship dodging only protects the player's Pokémon,
	; so the enemy must currently be attacking.
	ldh a, [hBattleTurn]
	and a
	ret z

	call CheckFriendshipBonusChance
	ret nc

	ld hl, FriendshipDodgedAttackText
	call StdBattleTextbox

	; Mark this miss as a friendship dodge so later effect
	; commands suppress their ordinary failure messages.
	ld a, 2
	ld [wAttackMissed], a
	ld [wEffectFailed], a

	; StdBattleTextbox may alter the flags.
	scf
	ret
	

ApplyFriendshipCriticalStage::
	; Only the player's Pokémon receives the friendship bonus.
	ldh a, [hBattleTurn]
	and a
	ret nz

	; Disable friendship bonuses in link battles.
	ld a, [wLinkMode]
	and a
	ret nz

	; Require high friendship.
	ld a, [wBattleMonHappiness]
	cp 220
	ret c

	; Critical stages cap at stage 4.
	ld a, c
	cp 4
	ret nc

	inc c
	ret
	

CheckFriendshipStatDropRecovery::
	; Preserve the stat-down routine's working registers.
	push hl
	push bc

	; Friendship only protects the player's Pokémon,
	; so the enemy must currently be using the move.
	ldh a, [hBattleTurn]
	and a
	jr z, .failed

	call CheckFriendshipBonusChance
	jr nc, .failed

	ld hl, FriendshipPreventedStatDropText
	call StdBattleTextbox
	
	; Prevent the stat-down animation and later effect text.
	ld a, 1
	ld [wAttackMissed], a

	; Success: restore registers and return carry set.
	scf
	pop bc
	pop hl
	ret

	; Success: restore registers and return carry set.
	scf
	pop bc
	pop hl
	ret

.failed
	; Failure: carry is already clear.
	pop bc
	pop hl
	ret