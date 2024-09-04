''
  //////////////////////////////////////////////////////
  //This file includes all racial units, heroes,
  //upgrades, buildings and abilities.  Please consult
  //CustomKeyInfo.txt for information on how to go about
  //using this file for customized hotkey support.
  //////////////////////////////////////////////////////


  /////////////////////////////
  //Shared Commands (attack, etc.)
  /////////////////////////////

  //move
  [CmdMove]
  Hotkey=M

  //attack
  [CmdAttack]
  Hotkey=A

  //attack ground
  [CmdAttackGround]
  Hotkey=G

  //build (generic)
  [CmdBuild]
  Hotkey=B

  //build (human)
  [CmdBuildHuman]
  Hotkey=B

  //build (orc)
  [CmdBuildOrc]
  Hotkey=B

  //build (nightelf)
  [CmdBuildNightElf]
  Hotkey=B

  //build (undead)
  [CmdBuildUndead]
  Hotkey=B

  //cancel
  [CmdCancel]
  Hotkey=27

  //cancel build
  [CmdCancelBuild]
  Hotkey=27

  //cancel train
  [CmdCancelTrain]
  Hotkey=27

  //cancel revive
  [CmdCancelRevive]
  Hotkey=27

  //hold position
  [CmdHoldPos]
  Hotkey=H

  //patrol
  [CmdPatrol]
  Hotkey=P

  //rally
  [CmdRally]
  Hotkey=Y

  //select skill
  [CmdSelectSkill]
  Hotkey=O

  //stop
  [CmdStop]
  Hotkey=S

  //normal harvest
  [Ahar]
  Hotkey=G
  Unhotkey=E

  //lumber harvest (ghoul)
  [Ahrl]
  Hotkey=G
  Unhotkey=E

  // peon/peasant repair ability
  [Arep]
  Hotkey=R
  Unhotkey=R

  // neutral interact (Select user command) which is used on player shops, etc
  [Anei]
  Hotkey=U

  // Cargo Load (Zeppelin)
  [Aloa]
  Hotkey=L

  // Cargo Unload (zeppelin)
  [Adro]
  Hotkey=U

  //cargo unload (sea transports)
  [Sdro]
  Hotkey=U

  /////////////////////////////
  //Human Units & Abilities
  /////////////////////////////

  //dragonhawk
  [hdhw]
  Hotkey=D

  // Aerial Shackles
  [Amls]
  Hotkey=E

  // Cloud
  [Aclf]
  Hotkey=C

  //footman
  [hfoo]
  Hotkey=F

  // Defend
  [Adef]
  Hotkey=D
  Unhotkey=D

  //flying machine
  [hgyr]
  Hotkey=F

  //knight
  [hkni]
  Hotkey=K

  //priest
  [hmpr]
  Hotkey=P

  // Inner Fire
  [Ainf]
  Hotkey=F
  Unhotkey=F

  // Heal
  [Ahea]
  Hotkey=E
  Unhotkey=E

  // Dispel Magic
  [Adis]
  Hotkey=D

  //mortar team
  [hmtm]
  Hotkey=M

  // Flare
  [Afla]
  Hotkey=F

  //peasant
  [hpea]
  Hotkey=P

  // Call to Arms (For one or several peons)
  [Amil]
  Hotkey=C
  Unhotkey=W

  // Call to Arms (for all nearby peons, on a town hall)
  [Amic]
  Hotkey=C
  Unhotkey=W

  //rifleman
  [hrif]
  Hotkey=R

  //sorceress
  [hsor]
  Hotkey=S

  // Slow
  [Aslo]
  Hotkey=W
  Unhotkey=W

  // Polymorph
  [Aply]
  Hotkey=O

  // Invisibility
  [Aivs]
  Hotkey=I

  //spell breaker
  [hspt]
  Hotkey=B

  // Spell Steal
  [Asps]
  Hotkey=T
  Unhotkey=T

  // Control Magic
  [Acmg]
  Hotkey=C

  //siege engine (without barrage)
  [hmtt]
  Hotkey=E

  //siege engine (with barrage)
  [hrtt]
  Hotkey=E

  //gryphon rider
  [hgry]
  Hotkey=G

  /////////////////////////////
  //Human Bldgs, Upgrades & Abilities
  /////////////////////////////

  //control magic
  [Rhss]
  Hotkey=G

  //iron swords upgrades
  [Rhme]
  Hotkey=S,S,S

  //gunpowder upgrades
  [Rhra]
  Hotkey=G,G,G

  //iron armor upgrades
  [Rhar]
  Hotkey=P,P,P

  //leather armor upgrades
  [Rhla]
  Hotkey=A,A,A

  //masonry upgrades
  [Rhac]
  Hotkey=M,M,M

  //flying machine bombs
  [Rhgb]
  Hotkey=B

  //improved lumber harvesting upgrades
  [Rhlh]
  Hotkey=L,L

  //defend upgrade
  [Rhde]
  Hotkey=D

  //war animal training upgrade
  [Rhan]
  Hotkey=A

  //priest training upgrade
  [Rhpt]
  Hotkey=T,T

  //sorceress training upgrade
  [Rhst]
  Hotkey=O,O

  //long rifles upgrade
  [Rhri]
  Hotkey=L

  //magic sentry upgrade
  [Rhse]
  Hotkey=M

  //flare upgrade
  [Rhfl]
  Hotkey=R

  //storm hammers upgrade
  [Rhhb]
  Hotkey=H

  //barrage upgrade
  [Rhrt]
  Hotkey=G

  //backpack upgrade
  [Rhpm]
  Hotkey=B

  //flak cannons upgrade
  [Rhfc]
  Hotkey=C

  //frag shards upgrade
  [Rhfs]
  Hotkey=S

  //cloud upgrade
  [Rhcd]
  Hotkey=C

  // Sundering Blades
  [Rhsb]
  Hotkey=B

  //altar of kings
  [halt]
  Hotkey=A

  //workshop
  [harm]
  Hotkey=W

  //arcane sanctum
  [hars]
  Hotkey=R

  //human barracks
  [hbar]
  Hotkey=B

  //blacksmith
  [hbla]
  Hotkey=S

  //castle
  [hcas]
  Hotkey=U

  //farm
  [hhou]
  Hotkey=F

  //gryphon aviary
  [hgra]
  Hotkey=G

  //Cannon Tower
  [hctw]
  Hotkey=C

  //guard tower
  [hgtw]
  Hotkey=G

  //scout tower
  [hwtw]
  Hotkey=T

  //arcane tower
  [hatw]
  Hotkey=N

  // reveal on arcane tower
  [AHta]
  Hotkey=R

  //arcane vault
  [hvlt]
  Hotkey=V

  //lumber mill
  [hlum]
  Hotkey=L

  //keep
  [hkee]
  Hotkey=U

  //town hall
  [htow]
  Hotkey=H


  /////////////////////////////
  //Human Heroes & Abilities
  /////////////////////////////

  //blood mage
  [Hblm]
  Hotkey=B

  // Siphon Mana
  [AHdr]
  Hotkey=N
  Researchhotkey=N

  // Flame Strike
  [AHfs]
  Hotkey=F
  Researchhotkey=F

  // Banish
  [AHbn]
  Hotkey=B
  Researchhotkey=B

  // Summon Phoenix
  [AHpx]
  Hotkey=X
  Researchhotkey=X

  //archmage
  [Hamg]
  Hotkey=A

  // Blizzard
  [AHbz]
  Hotkey=B
  Researchhotkey=B

  // Summon Water Elemental
  [AHwe]
  Hotkey=W
  Researchhotkey=W

  // Brilliance Aura
  [AHab]
  Researchhotkey=R

  // Mass Teleport
  [AHmt]
  Hotkey=T
  Researchhotkey=T

  //mountain king
  [Hmkg]
  Hotkey=M

  // Storm Bolt
  [AHtb]
  Hotkey=T
  Researchhotkey=T

  // Thunder Clap
  [AHtc]
  Hotkey=C
  Researchhotkey=C

  // Bash
  [AHbh]
  Researchhotkey=B

  // Avatar
  [AHav]
  Hotkey=V
  Unhotkey=V
  Researchhotkey=V

  //paladin
  [Hpal]
  Hotkey=L

  // Holy Light
  [AHhb]
  Hotkey=T
  Researchhotkey=T

  // Divine Shield
  [AHds]
  Hotkey=D
  Unhotkey=D
  Researchhotkey=D

  // Devotion Aura
  [AHad]
  Researchhotkey=V

  // Resurrection
  [AHre]
  Hotkey=R
  Researchhotkey=R


  /////////////////////////////
  //Orc Units & Abilities
  /////////////////////////////

  //demolisher
  [ocat]
  Hotkey=D

  //witch doctor
  [odoc]
  Hotkey=W

  // Sentry Ward
  [Aeye]
  Hotkey=W

  // Stasis Trap spell
  [Asta]
  Hotkey=T

  // Healing Ward
  [Ahwd]
  Hotkey=E

  //grunt
  [ogru]
  Hotkey=G

  //troll headhunter
  [ohun]
  Hotkey=T

  //troll berserker
  [otbk]
  Hotkey=T

  // Berserk
  [Absk]
  Hotkey=B

  //kodo beast
  [okod]
  Hotkey=K

  // Devour
  [Adev]
  Hotkey=D

  //peon
  [opeo]
  Hotkey=P

  //raider
  [orai]
  Hotkey=R

  // Ensnare
  [Aens]
  Hotkey=E

  //shaman
  [oshm]
  Hotkey=S

  // Purge
  [Aprg]
  Hotkey=G

  // Bloodlust
  [Ablo]
  Hotkey=B
  Unhotkey=B


  // Lightning Shield
  [Alsh]
  Hotkey=L

  //tauren
  [otau]
  Hotkey=T

  //troll batrider
  [otbr]
  Hotkey=B

  // Unstable Concoction
  [Auco]
  Hotkey=C
  Unhotkey=C


  //wind rider
  [owyv]
  Hotkey=W

  //spirit walker
  [ospm]
  Hotkey=T

  // Ancestral Spirit
  [Aast]
  Hotkey=C

  // Disenchant (new)
  [Adcn]
  Hotkey=D

  // Corporeal Form
  [Acpf]
  Hotkey=F
  Unhotkey=F

  // Ethereal Form
  [Aetf]
  Hotkey=F
  Unhotkey=F

  // Spirit Link
  [Aspl]
  Hotkey=R


  /////////////////////////////
  //Orc Bldgs, Upgrades & Abilities
  /////////////////////////////

  //orc melee weapon upgrades
  [Rome]
  Hotkey=M,M,M

  //orc ranged weapon upgrades
  [Rora]
  Hotkey=R,R,R

  //orc armor upgrades
  [Roar]
  Hotkey=A,A,A

  //war drums upgrade
  [Rwdm]
  Hotkey=D

  // pillage upgrade
  [Ropg]
  Hotkey=G

  //berserker strength upgrade
  [Robs]
  Hotkey=B

  //pulverize upgrade
  [Rows]
  Hotkey=P

  //ensnare upgrade
  [Roen]
  Hotkey=N

  //envenomed spears upgrade
  [Rovs]
  Hotkey=E

  //witch doctor training upgrade
  [Rowd]
  Hotkey=D,D

  //shaman training upgrade
  [Rost]
  Hotkey=M,M

  //spiked barricades upgrade
  [Rosp]
  Hotkey=S,S

  //troll regeneration upgrade
  [Rotr]
  Hotkey=R

  //liquid fire upgrade
  [Rolf]
  Hotkey=L

  //backpack upgrade (orc)
  [Ropm]
  Hotkey=B

  //spirit walker training upgrade
  [Rowt]
  Hotkey=R,R

  //troll berserker upgrade
  [Robk]
  Hotkey=E

  //reinforced defenses upgrade
  [Rorb]
  Hotkey=D

  //burning oil upgrade
  [Robf]
  Hotkey=N

  //altar of storms
  [oalt]
  Hotkey=A

  //orc barracks
  [obar]
  Hotkey=B

  //bestiary
  [obea]
  Hotkey=E

  //war mill
  [ofor]
  Hotkey=M

  //fortress
  [ofrt]
  Hotkey=U

  //great hall
  [ogre]
  Hotkey=H

  //spirit lodge
  [osld]
  Hotkey=S

  //stronghold
  [ostr]
  Hotkey=U

  //orc burrow
  [otrb]
  Hotkey=O

  //battle stations
  [Abtl]
  Hotkey=B

  //stand down from battle stations
  [Astd]
  Hotkey=D

  //reinforced orc burrow
  [orbr]
  Hotkey=O

  //tauren totem
  [otto]
  Hotkey=T

  //voodoo lounge
  [ovln]
  Hotkey=V

  //watch tower
  [owtw]
  Hotkey=W


  /////////////////////////////
  //Orc Heroes & Abilities
  /////////////////////////////

  [Obla]
  Hotkey=B

  // Wind Walk
  [AOwk]
  Hotkey=W
  Researchhotkey=W

  // Critical Strike
  [AOcr]
  Researchhotkey=C

  // Mirror Image
  [AOmi]
  Hotkey=R
  Researchhotkey=R

  // Bladestorm
  [AOww]
  Hotkey=B
  Researchhotkey=B

  [Ofar]
  Hotkey=F

  // Chain Lightning
  [AOcl]
  Hotkey=C
  Researchhotkey=C

  // Far Sight
  [AOfs]
  Hotkey=F
  Researchhotkey=F

  // Feral Spirit
  [AOsf]
  Hotkey=T
  Researchhotkey=T

  // Earthquake
  [AOeq]
  Hotkey=E
  Researchhotkey=E

  [Oshd]
  Hotkey=H

  // Healing Wave
  [AOhw]
  Hotkey=E
  Researchhotkey=E

  // Serpent Ward
  [AOsw]
  Hotkey=W
  Researchhotkey=W

  // Hex
  [AOhx]
  Hotkey=X
  Researchhotkey=X

  // Voodoo
  [AOvd]
  Hotkey=V
  Researchhotkey=V

  [Otch]
  Hotkey=T


  // Shockwave
  [AOsh]
  Hotkey=W
  Researchhotkey=W

  // Endurance Aura
  [AOae]
  Researchhotkey=E

  // War Stomp (Chieftan)
  [AOws]
  Hotkey=T
  Researchhotkey=T

  // Reincarnation
  [AOre]
  Researchhotkey=R


  /////////////////////////////
  //Night Elf Units & Abilities
  /////////////////////////////

  // Shadow Meld
  [Ashm]
  Hotkey=I

  //glaive thrower
  [ebal]
  Hotkey=T

  //chimaera
  [echm]
  Hotkey=C

  //druid of the claw, night elf form
  [edoc]
  Hotkey=C

  // Roar, night elf form
  [Aroa]
  Hotkey=R

  // Rejuvenation
  [Arej]
  Hotkey=E

  // Bear Form
  [Abrf]
  Hotkey=F
  Unhotkey=F

  // Roar (bear form)
  [Ara2]
  Hotkey=R

  //druid of the talon
  [edot]
  Hotkey=T

  // Faerie Fire
  [Afae]
  Hotkey=R
  Unhotkey=R

  // Cyclone
  [Acyc]
  Hotkey=C

  // Crow Form
  [Arav]
  Hotkey=F
  Unhotkey=F

  // Faerie Fire (Crow form)
  [Afa2]
  Hotkey=R
  Unhotkey=R

  //wisp
  [ewsp]
  Hotkey=W

  // Renew
  [Aren]
  Hotkey=R
  Unhotkey=R

  // Wisp Harvest
  [Awha]
  Hotkey=G

  // Detonate
  [Adtn]
  Hotkey=D

  //huntress
  [esen]
  Hotkey=H

  // Sentinel
  [Aesn]
  Hotkey=E

  //archer
  [earc]
  Hotkey=A

  // Mount Hippogryph
  [Aco2]
  Hotkey=U

  // Dismount Hippogryph
  [Adec]
  Hotkey=U

  //dryad
  [edry]
  Hotkey=D

  // Auto-Dispel Magic
  [Aadm]
  Hotkey=B
  Unhotkey=B

  //hippogryph
  [ehip]
  Hotkey=H

  // Pick up Archer
  [Aco3]
  Hotkey=U

  //mountain giant
  [emtg]
  Hotkey=G

  // War Club
  [Agra]
  Hotkey=W

  // Taunt
  [Atau]
  Hotkey=T

  //faerie dragon
  [efdr]
  Hotkey=F

  // Mana Flare
  [Amfl]
  Hotkey=F
  Unhotkey=F

  // Phase Shift
  [Apsh]
  Hotkey=E
  Unhotkey=E


  ////////////////////////////
  //Night Elf Bldgs, Upgrades & Abilities
  ////////////////////////////

  //strength of the moon upgrades
  [Resm]
  Hotkey=M,M,M

  //strength of the wild upgrades
  [Resw]
  Hotkey=W,W,W

  //moon armor upgrades
  [Rema]
  Hotkey=A,A,A

  //reinforced hide upgrades
  [Rerh]
  Hotkey=R,R,R

  //ultravision
  [Reuv]
  Hotkey=U

  //nature's blessing upgrade
  [Renb]
  Hotkey=N

  //improved bows upgrade
  [Reib]
  Hotkey=I

  //marksmanship upgrade
  [Remk]
  Hotkey=M

  //sentinel upgrade
  [Resc]
  Hotkey=S

  //moon glaive upgrade
  [Remg]
  Hotkey=G

  //druid of the talon training upgrade
  [Redt]
  Hotkey=A,A

  //druid of the claw training upgrade
  [Redc]
  Hotkey=L,L

  //abolish magic upgrade
  [Resi]
  Hotkey=S

  //hippogryph taming upgrade
  [Reht]
  Hotkey=I

  //corrosive breath upgrade
  [Recb]
  Hotkey=B

  //vorpal blades upgrade
  [Repb]
  Hotkey=P

  //resistant skin upgrade
  [Rers]
  Hotkey=T

  //hardened skin upgrade
  [Rehs]
  Hotkey=H

  //mark of the claw upgrade
  [Reeb]
  Hotkey=M

  //mark of the talon upgrade
  [Reec]
  Hotkey=M

  //wellspring upgrade
  [Rews]
  Hotkey=E

  //backpack upgrade
  [Repm]
  Hotkey=B

  // Eat Tree
  [Aeat]
  Hotkey=E

  // Root
  [Aroo]
  Hotkey=R
  Unhotkey=R

  //ancient protector
  [etrp]
  Hotkey=P

  //tree of life
  [etol]
  Hotkey=T

  // Entangle gold mine
  [Aent]
  Hotkey=G

  // Entangled Gold Mine Cargo (load/unload)
  [Aenc]
  Hotkey=L
  Unhotkey=U

  // Cargo Load entangled mine
  [Slo2]
  Hotkey=L

  // Cargo Unload (Instant, gold mine)
  [Adri]
  Hotkey=U



  //upgrade to tree of ages
  [etoa]
  Hotkey=U

  //upgrade to tree of eternity
  [etoe]
  Hotkey=U

  //hunter's hall
  [edob]
  Hotkey=H

  //altar of elders
  [eate]
  Hotkey=A

  //ancient of lore
  [eaoe]
  Hotkey=L

  //ancient of war
  [eaom]
  Hotkey=R

  //ancient of wind
  [eaow]
  Hotkey=W

  //ancient of wonders
  [eden]
  Hotkey=D

  //chimaera roost
  [edos]
  Hotkey=C

  //moon well
  [emow]
  Hotkey=M

  // Moon pool mana replenish
  [Ambt]
  Hotkey=R
  Unhotkey=R

  //////////////////////////////
  //Night Elf Heroes & Abilities
  //////////////////////////////

  //Demon Hunter
  [Edem]
  Hotkey=D

  // Mana Burn
  [AEmb]
  Hotkey=B
  Researchhotkey=B

  // Immolation
  [AEim]
  Hotkey=L
  Unhotkey=L
  Researchhotkey=L

  // Evasion
  [AEev]
  Researchhotkey=E

  // Metamorphosis
  [AEme]
  Hotkey=T
  Researchhotkey=T

  //keeper of the grove
  [Ekee]
  Hotkey=K

  // Entangling Roots
  [AEer]
  Hotkey=E
  Researchhotkey=E

  // Force of Nature
  [AEfn]
  Hotkey=F
  Researchhotkey=F

  // Thorns Aura
  [AEah]
  Researchhotkey=R

  // Tranquility
  [AEtq]
  Hotkey=T
  Researchhotkey=T

  //priestess of the moon
  [Emoo]
  Hotkey=P

  // Scout
  [AEst]
  Hotkey=C
  Researchhotkey=C

  // Searing Arrows
  [AHfa]
  Hotkey=R
  Unhotkey=R
  Researchhotkey=R

  // Trueshot Aura
  [AEar]
  Researchhotkey=T

  // Starfall
  [AEsf]
  Hotkey=F
  Researchhotkey=F

  //warden
  [Ewar]
  Hotkey=W

  // Blink
  [AEbl]
  Hotkey=B
  Researchhotkey=B

  // Fan of Knives
  [AEfk]
  Hotkey=F
  Researchhotkey=F

  // Shadow Strike
  [AEsh]
  Hotkey=D
  Researchhotkey=D


  // Avatar of Vengeance
  [AEsv]
  Hotkey=V
  Researchhotkey=V


  // Vengeance
  [Avng]
  Hotkey=V


  /////////////////////////////
  //Undead Units & Abilities
  /////////////////////////////

  //acolyte
  [uaco]
  Hotkey=C

  // Unsummon
  [Auns]
  Hotkey=U

  // Acolyte Harvest
  [Aaha]
  Hotkey=G
  Unhotkey=R

  // Restore (acolyte repair)
  [Arst]
  Hotkey=R
  Unhotkey=R

  //abomination
  [uabo]
  Hotkey=A

  // Cannibalize (abomination)
  [Acn2]
  Hotkey=C

  //banshee
  [uban]
  Hotkey=B

  // Curse
  [Acrs]
  Hotkey=C
  Unhotkey=C

  // Anti-magic Shell
  [Aams]
  Hotkey=N

  // Anti-magic Shell
  [Aam2]
  Hotkey=N

  // Possession
  [Apos]
  Hotkey=O

  // Possession
  [Aps2]
  Hotkey=O

  //crypt fiend
  [ucry]
  Hotkey=F

  // Web
  [Aweb]
  Hotkey=W
  Unhotkey=W

  // Burrow (crypt fiend)
  [Abur]
  Hotkey=B
  Unhotkey=B

  //frost wyrm
  [ufro]
  Hotkey=F

  //gargoyle
  [ugar]
  Hotkey=A

  // Stone Form
  [Astn]
  Hotkey=F
  Unhotkey=F

  //ghoul
  [ugho]
  Hotkey=G

  // Cannibalize (ghoul)
  [Acan]
  Hotkey=C

  //necromancer
  [unec]
  Hotkey=N

  // Raise Dead
  [Arai]
  Hotkey=R
  Unhotkey=R

  // Unholy Frenzy
  // [Auhf]
  // Hotkey=U

  // Incite Unholy Frenzy
  [Auuf]
  Hotkey=U

  // Cripple
  [Acri]
  Hotkey=C

  //meat wagon
  [umtw]
  Hotkey=M

  // Load Corpse
  [Amel]
  Hotkey=C
  Unhotkey=C

  // Unload Corpse
  [Amed]
  Hotkey=D

  //obsidian statue
  [uobs]
  Hotkey=O

  // Spirit Touch
  [Arpm]
  Hotkey=C
  Unhotkey=C

  // Essence of Blight
  [Arpl]
  Hotkey=B
  Unhotkey=B

  //destroyer
  [ubsp]
  Hotkey=T

  // Orb of Annihilation
  [Afak]
  Hotkey=O
  Unhotkey=O

  // Devour Magic
  [Advm]
  Hotkey=D


  // Absorb Mana
  [Aabs]
  Hotkey=B


  /////////////////////////////
  //Undead Bldgs, Upgrades & Abilities
  /////////////////////////////

  //destroy form upgrade
  [Rusp]
  Hotkey=T

  //unholy strength upgrades
  [Rume]
  Hotkey=S,S,S

  //creature attack upgrades
  [Rura]
  Hotkey=A,A,A

  //unholy armor upgrades
  [Ruar]
  Hotkey=U,U,U

  //creature carapace upgrades
  [Rucr]
  Hotkey=C,C,C

  //cannabalize upgrade
  [Ruac]
  Hotkey=C

  //ghoul frenzy upgrade
  [Rugf]
  Hotkey=Z

  //web upgrade
  [Ruwb]
  Hotkey=W

  //stone form upgrade
  [Rusf]
  Hotkey=S

  //necromancer training upgrades
  [Rune]
  Hotkey=E,E

  //banshee training upgrades
  [Ruba]
  Hotkey=A,A

  //freezing breath upgrade
  [Rufb]
  Hotkey=B

  //skeletal longevity upgrade
  [Rusl]
  Hotkey=S

  //disease cloud upgrade
  [Rupc]
  Hotkey=D

  //skeletal mastery upgrade
  [Rusm]
  Hotkey=M

  //burrow upgrade
  [Rubu]
  Hotkey=B

  //exhume corpses upgrade
  [Ruex]
  Hotkey=E

  //backpack upgrade
  [Rupm]
  EditorSuffix= (Undead)
  Hotkey=B

  //boneyard
  [ubon]
  Hotkey=B

  //sacrificial pit
  [usap]
  Hotkey=S

  // Sacrifice (Acolyte's button)
  [Alam]
  Hotkey=C

  //slaughterhouse
  [uslh]
  Hotkey=H

  //graveyard
  [ugrv]
  Hotkey=V

  //altar of darkness
  [uaod]
  Hotkey=A

  //necropolis
  [unpl]
  Hotkey=N

  //halls of the dead
  [unp1]
  Hotkey=U

  //black citadel
  [unp2]
  Hotkey=U

  //crypt
  [usep]
  Hotkey=C

  //temple of the damned
  [utod]
  Hotkey=T

  //tomb of relics
  [utom]
  Hotkey=R

  //haunted gold mine
  [ugol]
  Hotkey=G

  //ziggurat
  [uzig]
  Hotkey=Z

  //spirit tower
  [uzg1]
  Hotkey=T

  //nerubian tower
  [uzg2]
  Hotkey=N

  /////////////////////////////
  //Undead Heroes & Abilities
  /////////////////////////////

  //crypt lord
  [Ucrl]
  Hotkey=C

  // Impale
  [AUim]
  Hotkey=E
  Researchhotkey=E

  //spiked carapace
  [AUts]
  Researchhotkey=S

  // Carrion Beetles
  [AUcb]
  Hotkey=C
  Researchhotkey=C

  // Burrow (scarab lvl 2)
  [Abu2]
  Hotkey=B
  Unhotkey=B

  // Burrow (scarab lvl 3)
  [Abu3]
  Hotkey=B
  Unhotkey=B

  // Locust Swarm
  [AUls]
  Hotkey=L
  Researchhotkey=L

  //death knight
  [Udea]
  Hotkey=D

  // Death Coil
  [AUdc]
  Hotkey=C
  Researchhotkey=C

  // Unholy Aura
  [AUau]
  Researchhotkey=U

  // Death Pact
  [AUdp]
  Hotkey=E
  Researchhotkey=E

  // Animate Dead
  [AUan]
  Hotkey=D
  Researchhotkey=D

  //dreadlord
  [Udre]
  Hotkey=E

  // Carrion Swarm
  [AUcs]
  Hotkey=C
  Researchhotkey=C

  // Sleep
  [AUsl]
  Hotkey=E
  Researchhotkey=E

  // Vampiric Aura
  [AUav]
  Researchhotkey=V

  //inferno
  [AUin]
  Hotkey=N
  Researchhotkey=N

  //lich
  [Ulic]
  Hotkey=L

  // Frost Nova
  [AUfn]
  Hotkey=N
  Researchhotkey=N

  // Frost Armor (Autocast, Lich)
  [AUfu]
  Hotkey=F
  Researchhotkey=F

  // Dark Ritual
  [AUdr]
  Hotkey=R
  Researchhotkey=R

  // Death And Decay
  [AUdd]
  Hotkey=D
  Researchhotkey=D


  //////////////////////////////////////////////////////
  // Neutral heroes & neutral hero abilities
  // Includes neutral hero summoned unit abilities
  // Does not include mercenaries or mercenary abilities
  //////////////////////////////////////////////////////

  /////////////////////
  // Sea Witch Abilities
  /////////////////////

  //sea witch
  [Nngs]
  Hotkey=G

  // Mana Shield (Sea Witch)
  [ANms]
  Hotkey=N
  Unhotkey=N
  Researchhotkey=N

  // Forked Lightning (Sea Witch)
  [ANfl]
  Hotkey=F
  Researchhotkey=F

  // Frost Arrows (Sea Witch)
  [ANfa]
  Hotkey=R
  Unhotkey=R
  Researchhotkey=R

  // Tornado (Sea Witch)
  [ANto]
  Hotkey=T
  Researchhotkey=T

  /////////////////////
  // Pit Lord
  /////////////////////

  //pit lord
  [Nplh]
  Hotkey=I

  // Howl of Terror (Pit Lord)
  [ANht]
  Hotkey=T
  Researchhotkey=T

  // Rain of Fire (Pit Lord)
  [ANrf]
  Hotkey=F
  Researchhotkey=F

  // Cleaving Attack (Pit Lord)
  [ANca]
  Researchhotkey=C

  // Doom (Pit Lord)
  [ANdo]
  Hotkey=D
  Researchhotkey=D


  ////////////////////////////////
  // Pandaren Brewmaster
  ////////////////////////////////

  //pandaren brewmaster
  [Npbm]
  Hotkey=N

  // Breath of Fire (Pandaren Brewmaster)
  [ANbf]
  Hotkey=F
  Researchhotkey=F

  // Drunken Brawler (Pandaren Brewmaster)
  [ANdb]
  Researchhotkey=B

  // Drunken Haze (Pandaren Brewmaster)
  [ANdh]
  Hotkey=D
  Researchhotkey=D

  // Storm, Earth, and Fire (Pandaren Brewmaster)
  [ANef]
  Hotkey=E
  Researchhotkey=E


  //////////////////////
  //Mini-Panda Abilities
  //////////////////////

  // Wind Walk (wind panda)
  [ANwk]
  Hotkey=W

  // cyclone (Wind panda + various creeps -- shared ability)
  [ACcy]
  Hotkey=C

  // dispel magic (wind panda + various creeps -- shared ability)
  [Adsm]
  Hotkey=D

  // Taunt (earth panda)
  [ANta]
  Hotkey=T


  ////////////////////////
  // Beastmaster
  ////////////////////////

  //beastmaster
  [Nbst]
  Hotkey=S

  // Summon Bear (Beastmaster)
  [ANsg]
  Hotkey=B
  Researchhotkey=B

  // Summon Quilbeast (Beastmaster)
  [ANsq]
  Hotkey=Q
  Researchhotkey=Q

  // Summon Hawk (Beastmaster)
  [ANsw]
  Hotkey=W
  Researchhotkey=W

  // Stampede (Beastmaster)
  [ANst]
  Hotkey=T
  Researchhotkey=T

  // Blink (beastmaster bear)
  [ANbl]
  Hotkey=B


  ///////////////////////
  // Dark Ranger
  ///////////////////////

  [Nbrn]
  Hotkey=R

  // Black Arrow (Dark Ranger)
  [ANba]
  Hotkey=B
  Researchhotkey=B

  // Silence (Dark Ranger)
  [ANsi]
  Hotkey=E
  Researchhotkey=E

  // Life Drain  (Dark Ranger)
  [ANdr]
  Hotkey=D
  Researchhotkey=D

  // Charm (Dark Ranger)
  [ANch]
  Hotkey=C
  Researchhotkey=C


  ///////////////////////
  // Tinker
  ///////////////////////

  // Tinker
  [Ntin]
  Hotkey=Z

  // Tinker (morph / robo-goblin)
  [Nrob]
  Hotkey=Z

  // Pocket Factory
  [ANsy]
  Hotkey=F
  Researchhotkey=F

  // Pocket Factory
  [ANs1]
  Hotkey=F
  Researchhotkey=F

  // Pocket Factory
  [ANs2]
  Hotkey=F
  Researchhotkey=F

  // Pocket Factory
  [ANs3]
  Hotkey=F
  Researchhotkey=F

  // Cluster Rockets
  [ANcs]
  Hotkey=R
  Researchhotkey=R

  // Cluster Rockets
  [ANc1]
  Hotkey=R
  Researchhotkey=R

  // Cluster Rockets
  [ANc2]
  Hotkey=R
  Researchhotkey=R

  // Cluster Rockets
  [ANc3]
  Hotkey=R
  Researchhotkey=R

  // Engineering Upgrade
  [ANeg]
  Hotkey=E
  Researchhotkey=E

  // Robo-Goblin
  [ANrg]
  Hotkey=B
  Unhotkey=T
  Researchhotkey=B

  // Robo-Goblin
  [ANg1]
  Hotkey=B
  Unhotkey=T
  Researchhotkey=B

  // Robo-Goblin
  [ANg2]
  Hotkey=B
  Unhotkey=T
  Researchhotkey=B

  // Robo-Goblin
  [ANg3]
  Hotkey=B
  Unhotkey=T
  Researchhotkey=B

  // Demolish
  [ANde]
  Hotkey=

  // Demolish
  [ANd1]
  Hotkey=

  // Demolish
  [ANd2]
  Hotkey=

  // Demolish
  [ANd3]
  Hotkey=

  [ANfy]
  Hotkey=

  [ANf1]
  Hotkey=

  [ANf2]
  Hotkey=

  [ANf3]
  Hotkey=

  // Kaboom! (Clockwerk goblin level 1)
  [Asdg]
  Hotkey=B
  Unhotkey=B

  // Kaboom! (Clockwerk goblin level 2)
  [Asd2]
  Hotkey=B
  Unhotkey=B

  // Kaboom! (Clockwerk goblin level 3)
  [Asd3]
  Hotkey=B
  Unhotkey=B


  ///////////////////////
  // Alchemist
  ///////////////////////

  //alchemist
  [Nalc]
  Hotkey=X

  //alchemist
  [Nalm]
  Hotkey=X

  //alchemist (morph, 2)
  [Nal2]
  Hotkey=X

  //alchemist (morph, 3)
  [Nal3]
  Hotkey=X

  // Healing Spray
  [ANhs]
  Hotkey=E
  Researchhotkey=E

  // Acid Bomb
  [ANab]
  Hotkey=B
  Researchhotkey=B

  // Chemical Rage
  [ANcr]
  Hotkey=R
  Researchhotkey=R

  // Transmute
  [ANtm]
  Hotkey=T
  Researchhotkey=T


  ///////////////////////
  // Fire Lord
  ///////////////////////

  [Nfir]
  Hotkey=O

  // Incinerate
  [ANic]
  Hotkey=C
  Researchhotkey=C

  // Incinerate (Arrow)
  [ANia]
  Hotkey=C
  Researchhotkey=C

  // Soul Burn
  [ANso]
  Hotkey=B
  Researchhotkey=B

  // Summmon Lava Spawn
  [ANlm]
  Hotkey=W
  Researchhotkey=W

  // Volcano
  [ANvc]
  Hotkey=V
  Researchhotkey=V
''
