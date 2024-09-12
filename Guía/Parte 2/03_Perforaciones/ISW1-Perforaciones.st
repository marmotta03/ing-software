!classDefinition: #TestDePerforación category: #'ISW1-Perforaciones'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:00'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !


!classDefinition: #CapaDeSuelo category: #'ISW1-Perforaciones'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:36:05'!
esArenoso

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:36:19'!
esConcreto

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:36:31'!
esTierra

	self subclassResponsibility! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'MAM 9/11/2024 23:45:00'!
= unaCapaDeSuelo

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'MAM 9/12/2024 12:37:07'!
hash

	"^tipo hash + resistencia hash"! !



!CapaDeSuelo methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:47:56'!
tipo

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: #'ISW1-Perforaciones'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 23:42:06'!
arenoso

	^Arenoso new.! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 23:44:27'!
concretoConResistencia: resistencia 

	^Concreto new initializeWithResistance: resistencia! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 23:42:24'!
tierra

	^Tierra new.! !


!classDefinition: #Arenoso category: #'ISW1-Perforaciones'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Arenoso methodsFor: 'taladrar' stamp: 'MAM 9/11/2024 23:31:35'!
taladrarCon: unaPerforadoraParaTaladrar
	^unaPerforadoraParaTaladrar taladrarSueloArenoso.! !


!Arenoso methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:37:30'!
esArenoso
	^true! !

!Arenoso methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:37:36'!
esConcreto
	^false! !

!Arenoso methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:37:50'!
esTierra
	^false! !


!Arenoso methodsFor: 'comparing' stamp: 'MAM 9/11/2024 23:46:13'!
= unaCapaDeSuelo

	^unaCapaDeSuelo isKindOf: Arenoso! !


!Arenoso methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:48:05'!
tipo

	^Arenoso! !


!classDefinition: #Concreto category: #'ISW1-Perforaciones'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Concreto methodsFor: 'taladrar' stamp: 'MAM 9/11/2024 23:33:10'!
taladrarCon: unaPerforadoraParaTaladrar
	^unaPerforadoraParaTaladrar taladrarSueloConcreto.! !


!Concreto methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:05'!
esArenoso
^false! !

!Concreto methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:10'!
esConcreto
^true! !

!Concreto methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:18'!
esTierra
^false! !


!Concreto methodsFor: 'comparing' stamp: 'MAM 9/11/2024 23:46:49'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: Concreto) and: [resistencia = unaCapaDeSuelo resistencia]! !


!Concreto methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:48:54'!
resistencia

	^ resistencia.! !

!Concreto methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:48:13'!
tipo

	^Concreto! !


!Concreto methodsFor: 'bajar resistencia' stamp: 'MAM 9/11/2024 23:49:06'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!Concreto methodsFor: 'bajar resistencia' stamp: 'MAM 9/11/2024 23:48:42'!
sinResistencia
	^resistencia = 0! !


!Concreto methodsFor: 'initialization' stamp: 'MAM 9/11/2024 23:44:05'!
initializeWithResistance: aInitialResistance
	resistencia:=aInitialResistance! !


!classDefinition: #Tierra category: #'ISW1-Perforaciones'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Tierra methodsFor: 'taladrar' stamp: 'MAM 9/11/2024 23:33:22'!
taladrarCon: unaPerforadoraParaTaladrar
	^unaPerforadoraParaTaladrar taladrarSueloTierra.! !


!Tierra methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:25'!
esArenoso
^false! !

!Tierra methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:38'!
esConcreto
^false! !

!Tierra methodsFor: 'tipo' stamp: 'MAM 9/11/2024 23:38:50'!
esTierra
^true! !


!Tierra methodsFor: 'comparing' stamp: 'MAM 9/11/2024 23:47:11'!
= unaCapaDeSuelo

	^unaCapaDeSuelo isKindOf: Tierra! !


!Tierra methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:48:19'!
tipo

	^Tierra! !


!classDefinition: #Mecha category: #'ISW1-Perforaciones'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Mecha methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:00:01'!
taladrarCon: unaPerforadora

	self subclassResponsibility! !

!Mecha methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:11:42'!
taladrarSueloArenosoCon: unaPerforadora

	self subclassResponsibility! !

!Mecha methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:24:32'!
taladrarSueloConcretoCon: unaPerforadora

	self subclassResponsibility! !

!Mecha methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:24:45'!
taladrarSueloTierraCon: unaPerforadora

	self subclassResponsibility! !


!Mecha methodsFor: 'accessing' stamp: 'MAM 9/12/2024 12:32:08'!
mechaRota
	self subclassResponsibility ! !

!Mecha methodsFor: 'accessing' stamp: 'MAM 9/12/2024 12:31:51'!
sinMecha
	self subclassResponsibility ! !


!classDefinition: #Diamante category: #'ISW1-Perforaciones'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Diamante methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:00:01'!
taladrarCon: unaPerforadora
^unaPerforadora darGolpeDeTaladroConMecha.! !

!Diamante methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:12:00'!
taladrarSueloArenosoCon: unaPerforadora
^unaPerforadora taladrarSueloArenosoConDiamante .! !

!Diamante methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:36:51'!
taladrarSueloConcretoCon: unaPerforadora
^unaPerforadora taladrarSueloConcretoConDiamante .! !

!Diamante methodsFor: 'taladrar' stamp: 'MAM 9/12/2024 00:29:15'!
taladrarSueloTierraCon: unaPerforadora
^unaPerforadora taladrarSueloTierraConDiamante .! !


!Diamante methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:09:14'!
mechaRota
^false.! !

!Diamante methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:07:48'!
sinMecha
^false! !


!classDefinition: #Rota category: #'ISW1-Perforaciones'!
Mecha subclass: #Rota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:09:33'!
mechaRota
^true.! !

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:08:08'!
sinMecha
^false! !

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:00:01'!
taladrarCon: unaPerforadora
^unaPerforadora darGolpeDeTaladroConMecha.! !

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:23:37'!
taladrarSueloArenosoCon: unaPerforadora
^self error:'error'.! !

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:37:07'!
taladrarSueloConcretoCon: unaPerforadora
^self error:'error'.! !

!Rota methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:29:26'!
taladrarSueloTierraCon: unaPerforadora
^self error:'error'.! !


!classDefinition: #SinMecha category: #'ISW1-Perforaciones'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:09:41'!
mechaRota
^false.! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:08:15'!
sinMecha
^true! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:00:14'!
taladrarCon: unaPerforadora
^unaPerforadora taladrarSinMecha .! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:23:31'!
taladrarSueloArenosoCon: unaPerforadora
^self error:'error'.! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:37:17'!
taladrarSueloConcretoCon: unaPerforadora
^self error:'error'.! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:29:38'!
taladrarSueloTierraCon: unaPerforadora
^self error:'error'.! !


!classDefinition: #Soft category: #'ISW1-Perforaciones'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:09:47'!
mechaRota
^false.! !

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:08:25'!
sinMecha
^false! !

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:00:01'!
taladrarCon: unaPerforadora
^unaPerforadora darGolpeDeTaladroConMecha.! !

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:13:34'!
taladrarSueloArenosoCon: unaPerforadora
^unaPerforadora taladrarSueloArenosoConSoft .! !

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:37:33'!
taladrarSueloConcretoCon: unaPerforadora
^unaPerforadora taladrarSueloConcretoConSoft .! !

!Soft methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:29:50'!
taladrarSueloTierraCon: unaPerforadora
^unaPerforadora taladrarSueloTierraConSoft .! !


!classDefinition: #Widia category: #'ISW1-Perforaciones'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:09:53'!
mechaRota
^false.! !

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/11/2024 23:08:30'!
sinMecha
^false! !

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:00:01'!
taladrarCon: unaPerforadora
^unaPerforadora darGolpeDeTaladroConMecha.! !

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:13:51'!
taladrarSueloArenosoCon: unaPerforadora
^unaPerforadora taladrarSueloArenosoConWidia .! !

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:37:50'!
taladrarSueloConcretoCon: unaPerforadora
^unaPerforadora taladrarSueloConcretoConWidia .! !

!Widia methodsFor: 'as yet unclassified' stamp: 'MAM 9/12/2024 00:30:03'!
taladrarSueloTierraCon: unaPerforadora
^unaPerforadora taladrarSueloTierraConWidia .! !


!classDefinition: #Perforadora category: #'ISW1-Perforaciones'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Perforaciones'!

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:01:15'!
darGolpeDeTaladro
	mechaPuesta taladrarCon:self.
! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 12:29:37'!
darGolpeDeTaladroConMecha

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.
	
	self capaDeSueloInmediata taladrarCon: self.
	
	"self error: 'error'".! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:28:08'!
taladrarSueloArenoso
	mechaPuesta taladrarSueloArenosoCon: self.
		^self! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:07:26'!
taladrarSueloArenosoConDiamante
		mechaPuesta := Rota new. self error: 'Se rompió'.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:06:32'!
taladrarSueloArenosoConSoft


		^self pasarAProximaCapa.
! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:06:54'!
taladrarSueloArenosoConWidia
	 ^self pasarAProximaCapa.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:39:07'!
taladrarSueloConcreto

	mechaPuesta taladrarSueloConcretoCon: self.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:36:34'!
taladrarSueloConcretoConDiamante
	vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
	capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
			^vecesQueGolpeoCapaActual ! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:35:36'!
taladrarSueloConcretoConSoft

	mechaPuesta := Rota new. self error: 'Se rompió'  .
! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:36:02'!
taladrarSueloConcretoConWidia
 
	vecesQueGolpeoCapaActual = 3 ifTrue: [ mechaPuesta := Rota new. self error: 'Se rompió' ].
			^self ! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:28:28'!
taladrarSueloTierra

	mechaPuesta taladrarSueloTierraCon: self.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:27:19'!
taladrarSueloTierraConDiamante
		^self pasarAProximaCapa.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:26:36'!
taladrarSueloTierraConSoft

	 ^self.! !

!Perforadora methodsFor: 'perforar' stamp: 'MAM 9/12/2024 00:26:59'!
taladrarSueloTierraConWidia
		vecesQueGolpeoCapaActual = 2 ifTrue: [ ^self transformarCapaEnArenoso ].
			^self .! !


!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 9/3/2024 16:45:24'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self].! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'initialization' stamp: 'MAM 9/12/2024 00:02:48'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:09:22'!
conMechaRota

	^mechaPuesta mechaRota.! !

!Perforadora methodsFor: 'accessing' stamp: 'MAM 9/11/2024 23:10:04'!
sinMecha

	^mechaPuesta sinMecha.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'MAM 9/11/2024 23:10:44'!
ponerMechaDiamante
	mechaPuesta := Diamante new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MAM 9/11/2024 23:10:36'!
ponerMechaSoft
	mechaPuesta := Soft new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MAM 9/11/2024 23:10:29'!
ponerMechaWidia
	mechaPuesta := Widia new.! !


!Perforadora methodsFor: 'error messages' stamp: 'MAM 9/11/2024 22:59:13'!
taladrarSinMecha
^self error:'No puede perforar'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: #'ISW1-Perforaciones'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
