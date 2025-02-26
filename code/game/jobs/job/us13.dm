// CITIZENS

/datum/job/citizen
	title = "Citizen"
	department = "Civilians"
	social_class = SOCIAL_CLASS_LOW
	selection_color = "#cdcdff"

	min_skill = list( // untrained scum
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC)

	total_positions = -1
	spawn_positions = -1
	supervisors = "civil protection"

	outfit_type = /decl/hierarchy/outfit/job/citizen
	available_by_default = TRUE

/datum/job/cwu_overseer
	title = "CWU Overseer"
	social_class = SOCIAL_CLASS_MED
	selection_color = "#8b6229"
	department = "Civil Workers Union"

	require_whitelist = "administration"

	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the City Administrator"
	access = list(access_manufacturing, access_bridge)
	outfit_type = /decl/hierarchy/outfit/job/overseer
	available_by_default = TRUE

	min_skill = list(
		SKILL_BUREAUCRACY = SKILL_MASTER,
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC)

/datum/job/citizen/worker
	title = "Factory Worker"
	selection_color = "#8a704c"
	department = "Civil Workers Union"

	total_positions = 4
	spawn_positions = 4
	supervisors = "civil protection and the Factory Overseer"

	access = list(access_manufacturing)

	outfit_type = /decl/hierarchy/outfit/job/citizen/worker
	available_by_default = TRUE

/datum/job/citizen/worker/handle_variant_join(mob/living/carbon/human/H, alt_title)
	. = ..()
	return H

/datum/job/citizen/doctor
	title = "Medic"
	selection_color = "#8a704c"
	department = "Civil Workers Union"

	total_positions = 3
	spawn_positions = 3
	supervisors = "civil protection and the Factory Overseer"

	outfit_type = /decl/hierarchy/outfit/job/citizen/doctor
	available_by_default = TRUE

	min_skill = list(
		SKILL_COMBAT = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC,
		SKILL_ANATOMY = SKILL_EXPERIENCED,
		SKILL_MEDICAL = SKILL_EXPERIENCED)

// COPS

/datum/job/cp_rankleader
	title = "Civil Protection Rank Leader"
	department = "Civil Protection"
	supervisors = "the Administrator"
	req_admin_notify = 1
	social_class = SOCIAL_CLASS_COM
	head_position = TRUE
	selection_color = "#2f67ff"
	require_whitelist = "civilprotection"

	min_skill = list( // shouldnt be out in the field much
		SKILL_BUREAUCRACY = SKILL_EXPERIENCED,
		SKILL_COMBAT = SKILL_EXPERIENCED,
		SKILL_WEAPONS = SKILL_EXPERIENCED,
		SKILL_FORENSICS = SKILL_EXPERIENCED)

	total_positions = 1
	spawn_positions = 1

	outfit_type = /decl/hierarchy/outfit/job/cp/rankleader
	available_by_default = TRUE

/datum/job/cp_elite
	title = "Civil Protection Elite"
	department = "Civil Protection"
	supervisors = "rank leader"
	social_class = SOCIAL_CLASS_MED
	selection_color = "#6b92ff"
	require_whitelist = "civilprotection"

	min_skill = list(
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_EXPERIENCED,
		SKILL_FORENSICS = SKILL_TRAINED)

	total_positions = 3
	spawn_positions = 3

	outfit_type = /decl/hierarchy/outfit/job/cp/elite
	available_by_default = TRUE

/datum/job/cp_officer
	title = "Civil Protection Officer"
	department = "Civil Protection"
	supervisors = "elites and the rank leader"
	social_class = SOCIAL_CLASS_MED
	selection_color = "#9eb8ff"

	min_skill = list(
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED,
		SKILL_FORENSICS = SKILL_BASIC)

	total_positions = 5
	spawn_positions = 3

	outfit_type = /decl/hierarchy/outfit/job/cp/civilprotection
	available_by_default = TRUE

// CITY COMMAND

var/datum/announcement/minor/ca_announcement = new(do_newscast = 1)

/datum/job/cityadmin
	title = "City Administrator"
	department = "City Command"
	supervisors = "Combine officials and the Earth Administrator"
	social_class = SOCIAL_CLASS_MAX
	head_position = 1
	selection_color = "#ff0000ff"

	require_whitelist = "administration"

	access = list()
	minimal_access = list()

	total_positions = 1
	spawn_positions = 1

	outfit_type = /decl/hierarchy/outfit/job/earthadministrator
	available_by_default = TRUE

/datum/job/cityadmin/get_access()
	return get_all_station_access()

/datum/job/overwatch_elite
	title = "Overwatch Elite"
	department = "City Command"
	supervisors = "the City Administrator"
	social_class = SOCIAL_CLASS_HIGH
	selection_color = "#e70000ff"

	require_whitelist = "administration"

	access = list()
	minimal_access = list()

	total_positions = 2
	spawn_positions = 2

	min_skill = list( //killing machine
		SKILL_BUREAUCRACY = SKILL_UNTRAINED,
		SKILL_COMBAT = SKILL_MASTER,
		SKILL_WEAPONS = SKILL_MASTER,
		SKILL_FORENSICS = SKILL_UNTRAINED)

	outfit_type = /decl/hierarchy/outfit/job/cp/overwatch_elite
	available_by_default = TRUE

/datum/job/overwatch_elite/get_access()
	return get_all_station_access()

/datum/job/overwatch_elite/equip(mob/living/carbon/human/H, alt_title, datum/mil_branch/branch, datum/mil_rank/grade)
	if(!H)	return 0
	H.fully_replace_character_name("OTA::[pick("LEADER","FLASH","RANGER","HUNTER","BLADE","HAMMER","SCAR","SWEEPER","SWORD","SAVAGE","RAZOR")]>>[rand(1111,9999)]")
	. = ..()
	for(var/obj/item/clothing/clothing in list(H.head, H.wear_mask, H.wear_suit, H.w_uniform, H.gloves, H.shoes))
		clothing.canremove = 0
	if(prob(1))
		var/obj/item/clothing/accessory/pronouns/random = pick(typesof(/obj/item/clothing/accessory/pronouns))
		new random(get_turf(H))

/datum/job/overwatch_elite/handle_variant_join(mob/living/carbon/human/H, alt_title)
	if(!H) return
	H.add_language(/datum/language/human/english)
	return H.change_species(SPECIES_TRANNIE)
