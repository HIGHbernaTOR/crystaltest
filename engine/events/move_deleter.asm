MoveDeletion:
	ld hl, .DeleterIntroText
	call PrintText
	call YesNoBox
	jp c, .declined

	ld hl, .DeleterAskWhichMonText
	call PrintText

.loop_party_menu
	farcall SelectMonFromParty
	jp c, .declined

	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves + 1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	and a
	jr z, .onlyonemove
	
.loop_move_menu
	ld hl, .DeleterAskWhichMoveText
	call PrintText
	call LoadStandardMenuHeader
	farcall FadeOutToWhite
	farcall BlankScreen
	farcall ChooseMoveToDelete
	push af
	call ExitMenu
	call ReturnToMapWithSpeechTextbox
	pop af
	jr c, .choose_another_mon

	ld a, [wMenuCursorY]
	push af
	ld a, [wCurSpecies]
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, .AskDeleteMoveText
	call PrintText
	call YesNoBox
	pop bc
	jr c, .loop_move_menu

	call .DeleteMove
	ld de, SFX_MOVE_DELETED
	call PlaySFX
	call WaitSFX
	ld hl, .DeleterForgotMoveText
	call PrintText
	call YesNoBox
	jp nc, .loop_party_menu
	jr .declined

.choose_another_mon
	ld hl, .DeleterChooseAnotherMonText
	call PrintText
	call YesNoBox
	jp nc, .loop_party_menu
	jr .declined
	ret

.egg
	ld hl, .MailEggText
	call PrintText
	jp .loop_party_menu

.declined
	ld hl, .DeleterNoComeAgainText
	call PrintText
	ld c, 15
	call DelayFrames
	ret

.onlyonemove
	ld hl, .MoveKnowsOneText
	call PrintText
	jp .loop_party_menu

.MoveKnowsOneText:
	text_far _MoveKnowsOneText
	text_end

.AskDeleteMoveText:
	text_far _AskDeleteMoveText
	text_end

.DeleterForgotMoveText:
	text_far _DeleterForgotMoveText
	text_end

.MailEggText:
	text_far _DeleterEggText
	text_end
	
.DeleterChooseAnotherMonText:
	text_far _DeleterChooseAnotherMonText
	text_end

.DeleterNoComeAgainText:
	text_far _DeleterNoComeAgainText
	text_end

.DeleterAskWhichMoveText:
	text_far _DeleterAskWhichMoveText
	text_end

.DeleterIntroText:
	text_far _DeleterIntroText
	text_end

.DeleterAskWhichMonText:
	text_far _DeleterAskWhichMonText
	text_end

.DeleteMove:
	ld a, b
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, wPartyMon1Moves
	add hl, bc
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	push bc
	inc b
.loop
	ld a, b
	cp NUM_MOVES + 1
	jr z, .okay
	inc hl
	ld a, [hld]
	ld [hl], a
	inc hl
	inc b
	jr .loop

.okay
	xor a
	ld [hl], a
	pop bc

	ld a, b
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, wPartyMon1PP
	add hl, bc
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	inc b
.loop2
	ld a, b
	cp NUM_MOVES + 1
	jr z, .done
	inc hl
	ld a, [hld]
	ld [hl], a
	inc hl
	inc b
	jr .loop2

.done
	xor a
	ld [hl], a
	ret
