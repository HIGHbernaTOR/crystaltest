NatureNames:
	table_width MON_NAME_LENGTH - 1
	db "HARDY@@@@@"
	db "LONELY@@@@"
	db "BRAVE@@@@@"
	db "ADAMANT@@@"
	db "NAUGHTY@@@"
	db "BOLD@@@@@@"
	db "DOCILE@@@@"
	db "RELAXED@@@"
	db "IMPISH@@@@"
	db "LAX@@@@@@@"
	db "TIMID@@@@@"
	db "HASTY@@@@@"
	db "SERIOUS@@@"
	db "JOLLY@@@@@"
	db "NAIVE@@@@@"
	db "MODEST@@@@"
	db "MILD@@@@@@"
	db "QUIET@@@@@"
	db "BASHFUL@@@"
	db "RASH@@@@@@"
	db "CALM@@@@@@"
	db "GENTLE@@@@"
	db "SASSY@@@@@"
	db "CAREFUL@@@"
	db "QUIRKY@@@@"
	assert_table_length NUM_NATURES

NatureEffects:
	table_width 2
	; raised stat, lowered stat

	; Attack-raising group
	db NATURE_NEUTRAL,  NATURE_NEUTRAL  ; Hardy
	db NATURE_STAT_ATK, NATURE_STAT_DEF ; Lonely
	db NATURE_STAT_ATK, NATURE_STAT_SPD ; Brave
	db NATURE_STAT_ATK, NATURE_STAT_SAT ; Adamant
	db NATURE_STAT_ATK, NATURE_STAT_SDF ; Naughty

	; Defense-raising group
	db NATURE_STAT_DEF, NATURE_STAT_ATK ; Bold
	db NATURE_NEUTRAL,  NATURE_NEUTRAL  ; Docile
	db NATURE_STAT_DEF, NATURE_STAT_SPD ; Relaxed
	db NATURE_STAT_DEF, NATURE_STAT_SAT ; Impish
	db NATURE_STAT_DEF, NATURE_STAT_SDF ; Lax

	; Speed-raising group
	db NATURE_STAT_SPD, NATURE_STAT_ATK ; Timid
	db NATURE_STAT_SPD, NATURE_STAT_DEF ; Hasty
	db NATURE_NEUTRAL,  NATURE_NEUTRAL  ; Serious
	db NATURE_STAT_SPD, NATURE_STAT_SAT ; Jolly
	db NATURE_STAT_SPD, NATURE_STAT_SDF ; Naive

	; Special Attack-raising group
	db NATURE_STAT_SAT, NATURE_STAT_ATK ; Modest
	db NATURE_STAT_SAT, NATURE_STAT_DEF ; Mild
	db NATURE_STAT_SAT, NATURE_STAT_SPD ; Quiet
	db NATURE_NEUTRAL,  NATURE_NEUTRAL  ; Bashful
	db NATURE_STAT_SAT, NATURE_STAT_SDF ; Rash

	; Special Defense-raising group
	db NATURE_STAT_SDF, NATURE_STAT_ATK ; Calm
	db NATURE_STAT_SDF, NATURE_STAT_DEF ; Gentle
	db NATURE_STAT_SDF, NATURE_STAT_SPD ; Sassy
	db NATURE_STAT_SDF, NATURE_STAT_SAT ; Careful
	db NATURE_NEUTRAL,  NATURE_NEUTRAL  ; Quirky

	assert_table_length NUM_NATURES