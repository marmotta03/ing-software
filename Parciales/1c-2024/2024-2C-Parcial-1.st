!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:29:01'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'MAM 9/27/2024 20:39:49'!
test13UnAventureroPierdeTodosSusPuntosDeVidaEsDerrotadoYNoPuedeAtacar

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0).
	self assert: (mago fueDerrotado ).
	
	self should: [mago atacarA: ogro con: itemDeAtaque] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: mago noSePuedeAtacarUnaVezDerrotadoMensajeDeError
	]! !

!TestMyA methodsFor: 'tests' stamp: 'MAM 9/27/2024 20:39:27'!
test14UnMonstruoPierdeTodosSusPuntosDeVidaEsDerrotadoYNoPuedeAtacar

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0).
	self assert: (goblin fueDerrotado ).
	
	self should: [goblin atacarA: mago] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: goblin noSePuedeAtacarUnaVezDerrotadoMensajeDeError
	]! !


!TestMyA methodsFor: 'crear items' stamp: 'MAM 9/27/2024 20:09:08'!
crearArmadura

	^ItemDeDefensa armadura.! !

!TestMyA methodsFor: 'crear items' stamp: 'MAM 9/27/2024 18:50:57'!
crearBaculo
	
	^Báculo new.! !

!TestMyA methodsFor: 'crear items' stamp: 'MAM 9/27/2024 20:09:12'!
crearEscudoMagico

	^ItemDeDefensa escudoMagico .
! !

!TestMyA methodsFor: 'crear items' stamp: 'MAM 9/27/2024 18:49:07'!
crearEspadaPara: unMonstruoObjetivo

	^Espada espadaPara:unMonstruoObjetivo.
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'MAM 9/27/2024 17:50:57'!
crearGoblin

	^Goblin new
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MAM 9/27/2024 17:50:50'!
crearGuerrero
	
	^Guerrero new.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MAM 9/27/2024 19:21:08'!
crearMago

	^Mago new.
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'MAM 9/27/2024 18:32:07'!
crearOgro

	^Ogro new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !


!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza puntosDeVida itemsDeDefensa itemsDeAtaque'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:16:25'!
atacarA: unMonstruoAAtacar con: itemDeAtaque
	self subclassResponsibility .
	! !


!Aventurero methodsFor: 'inventario' stamp: 'MAM 9/27/2024 18:43:11'!
equiparItemDeAtaque: itemDeAtaque
	itemsDeAtaque add:itemDeAtaque .! !

!Aventurero methodsFor: 'inventario' stamp: 'MAM 9/27/2024 18:43:16'!
equiparItemDeDefensa: unItemDeDefensa
	itemsDeDefensa add:unItemDeDefensa .! !

!Aventurero methodsFor: 'inventario' stamp: 'MAM 9/27/2024 19:43:46'!
estaEnInventario: unItemAVerifcar

	^ (itemsDeDefensa includes: unItemAVerifcar)or:(itemsDeAtaque includes: unItemAVerifcar)! !

!Aventurero methodsFor: 'inventario' stamp: 'MAM 9/27/2024 18:43:33'!
puntosDeVidaItemsDeDefensa
	^itemsDeDefensa sum:[:unItemDeDefensa| unItemDeDefensa puntosDeVidaProtegidos] ifEmpty:(0*pv).! !


!Aventurero methodsFor: 'mensajes error' stamp: 'MAM 9/27/2024 18:40:47'!
itemNoDisponibleMensajeDeError
	^'El item no está en el inventario.'! !

!Aventurero methodsFor: 'mensajes error' stamp: 'MAM 9/27/2024 20:21:16'!
noSePuedeAtacarUnaVezDerrotadoMensajeDeError
	^'El aventurero fue derrotado y ya no puede atacar.'! !


!Aventurero methodsFor: 'testing' stamp: 'MAM 9/27/2024 21:09:02'!
fueDerrotado

	^ puntosDeVida <=(0*pv)! !

!Aventurero methodsFor: 'testing' stamp: 'MAM 9/27/2024 18:00:40'!
tienePuntosDeVida: puntosDeVidaEstimados
	^puntosDeVida = puntosDeVidaEstimados .! !


!Aventurero methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:48:07'!
dañoGeneradoPorAtaqueConPuntosDeVida: puntosDeVidaAtacantes
	^ 0*pv max: (puntosDeVidaAtacantes - (self puntosDeVidaItemsDeDefensa))! !

!Aventurero methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:47:53'!
recibirAtaqueConPuntosDeVida: puntosDeVidaAtacantes
	puntosDeVida:= puntosDeVida - (self dañoGeneradoPorAtaqueConPuntosDeVida: puntosDeVidaAtacantes)! !


!Aventurero methodsFor: 'verificaciones(asserts)' stamp: 'MAM 9/27/2024 20:22:35'!
puedeAtacarCon: itemDeAtaque

	self verificarItemEnInventario: itemDeAtaque.
	self verificarNoEstaDerrotado! !

!Aventurero methodsFor: 'verificaciones(asserts)' stamp: 'MAM 9/27/2024 19:44:09'!
verificarItemEnInventario: unItemAVerifcar
	^(self estaEnInventario: unItemAVerifcar) ifFalse:[self error: self itemNoDisponibleMensajeDeError ]! !

!Aventurero methodsFor: 'verificaciones(asserts)' stamp: 'MAM 9/27/2024 20:38:52'!
verificarNoEstaDerrotado
	^self fueDerrotado ifTrue:[self error: self noSePuedeAtacarUnaVezDerrotadoMensajeDeError ]! !


!Aventurero methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:51:38'!
inicializarConFuerza: fuerzaInicial yPuntosDeVida: puntosDeVidaIniciales
	fuerza:=fuerzaInicial .
	puntosDeVida :=puntosDeVidaIniciales .
	itemsDeDefensa:=OrderedCollection new.
	itemsDeAtaque:=OrderedCollection new.! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:52:41'!
initialize
	self inicializarConFuerza:(4*pv)yPuntosDeVida:(10*pv).! !


!Guerrero methodsFor: 'ataque' stamp: 'MAM 9/27/2024 20:23:10'!
atacarA: unMonstruoAAtacar con: itemDeAtaque
	self puedeAtacarCon: itemDeAtaque .
	itemDeAtaque seUtilizaPorGuerrero: self paraAtacar:unMonstruoAAtacar conFuerza:fuerza.! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:52:33'!
initialize
	self inicializarConFuerza: (2*pv) yPuntosDeVida: (15*pv).! !


!Mago methodsFor: 'ataque' stamp: 'MAM 9/27/2024 20:22:27'!
atacarA: unMonstruoAAtacar con: itemDeAtaque
	self puedeAtacarCon: itemDeAtaque.
	itemDeAtaque seUtilizaPorMago: self paraAtacar:unMonstruoAAtacar conFuerza: fuerza.! !

!Mago methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:26:25'!
intentaAtacarConEspada
	puntosDeVida := 0*pv.! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:49:24'!
seUtilizaPorGuerrero: unGuerrero paraAtacar: unMonstruoAAtacar conFuerza: fuerzaDeAtaque

	self subclassResponsibility! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:49:08'!
seUtilizaPorMago: unMago paraAtacar: unMonstruoAAtacar conFuerza: fuerzaDeAtaque

	self subclassResponsibility! !


!classDefinition: #Báculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Báculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Báculo methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:31:19'!
seUtilizaPorGuerrero: unGuerrero paraAtacar: unMonstruoAAtacar conFuerza:fuerzaDeAtaque
	unMonstruoAAtacar recibirAtaqueDeGuerreroConBaculoConFuerza: fuerzaDeAtaque.
	! !

!Báculo methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:31:52'!
seUtilizaPorMago: unMago paraAtacar: unMonstruoAAtacar conFuerza:fuerzaDeAtaque
	unMonstruoAAtacar recibirAtaqueDeMagoConBaculoConFuerza: fuerzaDeAtaque.! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoObjetivo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:28:15'!
seUtilizaPorGuerrero: unGuerrero paraAtacar: unMonstruoAAtacar conFuerza: fuerzaDeAtaque
	unMonstruoAAtacar = monstruoObjetivo ifTrue:[unMonstruoAAtacar recibirAtaqueDeGuerreroConEspadaConFuerza: fuerzaDeAtaque ].! !

!Espada methodsFor: 'ataque' stamp: 'MAM 9/27/2024 19:26:19'!
seUtilizaPorMago: unMago paraAtacar:unMonstruoAAtacar conFuerza: fuerzaDeAtaque
	unMago intentaAtacarConEspada.! !


!Espada methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:44:03'!
inicializarConMonstruoObjetivo: unMonstruoObjetivo
	monstruoObjetivo :=unMonstruoObjetivo .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'creacion instancias' stamp: 'MAM 9/27/2024 20:44:03'!
espadaPara: unMonstruoObjetivo
	self assertAlturaDelMonstruo: unMonstruoObjetivo .
	^self new inicializarConMonstruoObjetivo: unMonstruoObjetivo .! !


!Espada class methodsFor: 'verificaciones(asserts)' stamp: 'MAM 9/27/2024 18:55:40'!
assertAlturaDelMonstruo: unMonstruoObjetivo
	(unMonstruoObjetivo altura)<(1*meter) ifTrue:[self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ].! !


!Espada class methodsFor: 'mensajes error' stamp: 'MAM 9/27/2024 18:55:19'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	^'La espada no puede atacar a monstruos menores a un metro!!'! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'puntosDeVidaProtegidos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'proteccion' stamp: 'MAM 9/27/2024 18:19:24'!
puntosDeVidaProtegidos
	^puntosDeVidaProtegidos .! !


!ItemDeDefensa methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:09:50'!
inicializarConProteccionDePuntos: puntosAProteger
	puntosDeVidaProtegidos :=puntosAProteger .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'creacion instancias' stamp: 'MAM 9/27/2024 20:09:59'!
armadura
	^self new inicializarConProteccionDePuntos:5*pv.! !

!ItemDeDefensa class methodsFor: 'creacion instancias' stamp: 'MAM 9/27/2024 20:10:06'!
escudoMagico
	^self new inicializarConProteccionDePuntos:3*pv.! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'altura puntosDeVida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:52:57'!
recibirAtaqueDeGuerreroConBaculoConFuerza: fuerzaDeAtaque

	self subclassResponsibility! !

!Monstruo methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:13:54'!
recibirAtaqueDeGuerreroConEspadaConFuerza: fuerza
	puntosDeVida := puntosDeVida -fuerza.! !

!Monstruo methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:53:03'!
recibirAtaqueDeMagoConBaculoConFuerza: fuerzaDeAtaque

	self subclassResponsibility! !


!Monstruo methodsFor: 'testing' stamp: 'MAM 9/27/2024 21:09:14'!
fueDerrotado

	^ puntosDeVida <=(0*pv)! !

!Monstruo methodsFor: 'testing' stamp: 'MAM 9/27/2024 18:56:19'!
tienePuntosDeVida: puntosDeVidaEstimados
	^puntosDeVida = puntosDeVidaEstimados .! !


!Monstruo methodsFor: 'accessing' stamp: 'MAM 9/27/2024 18:54:20'!
altura
	^altura! !


!Monstruo methodsFor: 'ataque' stamp: 'MAM 9/27/2024 20:27:56'!
atacarA: unAventurero
	self puedeAtacar.
	unAventurero recibirAtaqueConPuntosDeVida: puntosDeVida .! !


!Monstruo methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:14:07'!
inicializarConAltura: unaAltura yPuntosDeVida: puntosDeVidaIniciales
	altura :=unaAltura .
	puntosDeVida := puntosDeVidaIniciales .! !


!Monstruo methodsFor: 'verificaciones(asserts)' stamp: 'MAM 9/27/2024 20:40:23'!
puedeAtacar
	self fueDerrotado ifTrue:[self error: self noSePuedeAtacarUnaVezDerrotadoMensajeDeError]! !


!Monstruo methodsFor: 'mensajes error' stamp: 'MAM 9/27/2024 20:27:25'!
noSePuedeAtacarUnaVezDerrotadoMensajeDeError
	^'El monstruo fue derrotado y ya no puede atacar.'! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:14:40'!
initialize
	self inicializarConAltura: (90*centimeter) yPuntosDeVida: (5*pv).! !


!Goblin methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:32:42'!
recibirAtaqueDeGuerreroConBaculoConFuerza: fuerzaDeAtaque.
	puntosDeVida := puntosDeVida *2.! !

!Goblin methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:33:07'!
recibirAtaqueDeMagoConBaculoConFuerza: fuerzaDeAtaque.
	puntosDeVida := 0*pv.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'inicializar' stamp: 'MAM 9/27/2024 20:14:31'!
initialize
	self inicializarConAltura: (220*centimeter) yPuntosDeVida: (15*pv).! !


!Ogro methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:33:39'!
recibirAtaqueDeGuerreroConBaculoConFuerza: fuerzaDeAtaque
	puntosDeVida := puntosDeVida -fuerzaDeAtaque .! !

!Ogro methodsFor: 'defensa' stamp: 'MAM 9/27/2024 19:33:47'!
recibirAtaqueDeMagoConBaculoConFuerza: fuerzaDeAtaque
	puntosDeVida := puntosDeVida -fuerzaDeAtaque .! !

TestMyA initialize!