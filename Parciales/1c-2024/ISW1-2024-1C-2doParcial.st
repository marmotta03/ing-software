!classDefinition: #ProjectTests category: #'ISW1-2024-1C-2doParcial'!
TestCase subclass: #ProjectTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 13:36:58'!
test01tareaConcretaSinDependientesConDesarrolladorDeIgualDedicacionFinalizaElMismoDia
	|tareaConcreta|
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 8*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/1/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 15:28:00'!
test02tareaConcretaSinDependientesConDesarrolladorDeDistintaDedicacionFinalizaSegunEsfuerzo
	|tareaConcreta|
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/2/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 15:34:06'!
test03tareaConcretaSinDependientesConEquipoDeDesarrolladoresDeMismaDedicacionFinalizaSegunEsfuerzo
	|tareaConcreta|
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self equipoFormadoPor: (OrderedCollection
																			with:(self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
																			with: (self desarrollador: 'Lucas' conDedicacion: 6*hour/day costoPorHora: 100*peso)))
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/2/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 15:38:48'!
test04tareaConcretaSinDependientesConEquipoDeDesarrolladoresFinalizaSegunEsfuerzoConElMasLento
	|tareaConcreta|
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self equipoFormadoPor: (OrderedCollection
																			with:(self desarrollador: 'Pepe' conDedicacion: 8*hour/day costoPorHora: 100*peso)
																			with: (self desarrollador: 'Lucas' conDedicacion: 6*hour/day costoPorHora: 100*peso)))
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/2/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 16:01:06'!
test05tareaConcretaSinDependientesConEquipoDeSubEquiposFinalizaSegunEsfuerzoConElMasLento
	|tareaConcreta subequipo1 subequipo2 equipo|
	subequipo1:=self equipoFormadoPor:(OrderedCollection with:(self desarrollador: 'Pepe' conDedicacion: 8*hour/day costoPorHora: 100*peso)
														     with: (self desarrollador: 'Lucas' conDedicacion: 5*hour/day costoPorHora: 100*peso)).
														
	subequipo2:=self equipoFormadoPor:(OrderedCollection with:(self desarrollador: 'Constanza' conDedicacion: 10*hour/day costoPorHora: 100*peso)
														     with: (self desarrollador: 'Maria' conDedicacion: 3*hour/day costoPorHora: 100*peso)).
	
	equipo:= self equipoFormadoPor:(OrderedCollection with: subequipo1 with:subequipo2 ).
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: equipo
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/3/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 16:05:13'!
test05tareaConcretaSinDependientesConEquipoDeSubEquiposYDesarrolladoresFinalizaSegunEsfuerzoConElMasLento
	|tareaConcreta subequipo1 subequipo2 equipo desarrollador1 desarrollador2|
	subequipo1:=self equipoFormadoPor:(OrderedCollection with:(self desarrollador: 'Pepe' conDedicacion: 8*hour/day costoPorHora: 100*peso)
														     with: (self desarrollador: 'Lucas' conDedicacion: 5*hour/day costoPorHora: 100*peso)).
														
	subequipo2:=self equipoFormadoPor:(OrderedCollection with:(self desarrollador: 'Constanza' conDedicacion: 10*hour/day costoPorHora: 100*peso)
														     with: (self desarrollador: 'Maria' conDedicacion: 3*hour/day costoPorHora: 100*peso)).
	
	desarrollador1:= self desarrollador: 'Pato' conDedicacion: (12*hour/day) costoPorHora: 100*peso.
	
	desarrollador2:= self desarrollador: 'Pato' conDedicacion: (11*hour/day) costoPorHora: 100*peso.
	
	equipo:= self equipoFormadoPor:(OrderedCollection with: subequipo1 with:subequipo2 with:desarrollador1 with:desarrollador2 ).
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: equipo
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/3/2024.! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 16:11:31'!
test06laDedicacionDelDesarrolladorDebeSerPositiva
	
	self should: [self desarrollador: 'Tito' conDedicacion: (-3*hour/day) costoPorHora: 100*peso]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Desarrollador dedicacionNoPositivaErrorDescription ].! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 18:48:43'!
test07elCostoPorHoraDelDesarrolladorDebeSerPositivo
	
	self should: [self desarrollador: 'Tito' conDedicacion: (3*hour/day) costoPorHora: -100*peso]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Desarrollador costoPorHoraNoPositivoErrorDescription ].! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 19:16:49'!
test08tareaEsperaAQueSuDependienteFinalice
	|tareaConcreta tareaDeLaQueDepende|
	
	tareaDeLaQueDepende:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pedro' conDedicacion: 2*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 10*hour
						dependientes: (OrderedCollection new).
	"termina el 5 de julio"
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection with:tareaDeLaQueDepende).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/7/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 19:19:58'!
test09tareaConMuchosDependientesEsperaAQueFinalicen
	|tareaConcreta tareaDeLaQueDepende1 tareaDeLaQueDepende2|
	"tomamos que debe empezar a partir del dia siguiente de que termina su ultima tarea dependiente"
	
	tareaDeLaQueDepende1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pedro' conDedicacion: 2*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 10*hour
						dependientes: (OrderedCollection new).
	"termina el 5 de julio"
	
	tareaDeLaQueDepende2:=self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Romina' conDedicacion: 4*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 40*hour
						dependientes: (OrderedCollection new).
	"termina el 10 de julio"
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection with:tareaDeLaQueDepende1 with:tareaDeLaQueDepende2 ).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/12/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/16/2024 19:37:13'!
test10tareaConMuchosDependientesEsperaAQueFinalicenYFechaDeInicioDeseada
	|tareaConcreta tareaDeLaQueDepende1 tareaDeLaQueDepende2|
	"tomamos que debe empezar a partir del dia siguiente de que termina su ultima tarea dependiente"
	
	tareaDeLaQueDepende1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pedro' conDedicacion: 2*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 10*hour
						dependientes: (OrderedCollection new).
	"termina el 5 de julio"
	
	tareaDeLaQueDepende2:=self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Romina' conDedicacion: 4*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 40*hour
						dependientes: (OrderedCollection new).
	"termina el 10 de julio"
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/15/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection with:tareaDeLaQueDepende1 with:tareaDeLaQueDepende2 ).
	
	self assert: tareaConcreta fechaDeFinalizacion equals: July/16/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 16:30:05'!
test11proyectoConUnaTareaEmpiezaEnLaFechaDeInicioDeLaTarea
	|tareaConcreta proyecto|
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 8*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
						
	proyecto:= self proyecto: 'Pupito' formadoPor:		 (OrderedCollection with:tareaConcreta) .
	
	self assert: proyecto fechaDeInicio equals: July/1/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 16:31:59'!
test12proyectoConVariasTareasEmpiezaConSuTareaMasTemprana
	|tareaConcreta1 tareaConcreta2 proyecto|
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	self assert: proyecto fechaDeInicio equals: July/1/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 16:34:53'!
test13proyectoConUnaTareaTerminaEnLaFechaDeFinalizacionDeLaTarea
	|tareaConcreta proyecto|
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 8*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
						
	proyecto:= self proyecto: 'Pupito' formadoPor:		 (OrderedCollection with:tareaConcreta) .
	
	self assert: proyecto fechaDeFinalizacion equals: July/1/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 16:35:55'!
test14proyectoConVariasTareasTerminaConSuTareaMasTarde
	|tareaConcreta1 tareaConcreta2 proyecto|
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	self assert: proyecto fechaDeFinalizacion equals: July/3/2024.
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 18:34:51'!
test15diasDeTrabajoDeProyectoDeUnDesarrolladorExternoSonNulos
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	self assert: (desarrollador diasDeTrabajoEnProyecto: proyecto) equals: (OrderedCollection new).
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 18:41:13'!
test16diasDeTrabajoDeProyectoDeUnaTareaDeUnDesarrolladorInternoSonLosDiasDeLaTarea
	|tareaConcreta1 desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	
	self assert: (desarrollador diasDeTrabajoEnProyecto: tareaConcreta1 ) equals: (OrderedCollection with:July/1/2024 with:July/2/2024).
	
	! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 18:58:53'!
test17diasDeTrabajoDeProyectoDeVariasTareasDeUnDesarrolladorInternoSonLosDiasDeLaTareaQueHace
	
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	self assert: (desarrollador diasDeTrabajoEnProyecto: proyecto) equals: (OrderedCollection with: July/1/2024 with:July/2/2024).! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 19:38:20'!
test18diasDeTrabajoDeProyectoDeVariasTareasDeUnDesarrolladorInternoSonLosDiasDeTodasLasTareasQueHaceSinSuperposiciones
	
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador diasDeTrabajo|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/4/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
	
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	"trabaja el 1, 2, 4,5,6,7,8,9,10,11"
	diasDeTrabajo:=OrderedCollection new.
	((July/1/2024) to: (July/2/2024)) do:[:aDay|diasDeTrabajo add:aDay].
	((July/4/2024) to: (July/11/2024)) do:[:aDay|diasDeTrabajo add:aDay].

	
	self assert: (desarrollador diasDeTrabajoEnProyecto: proyecto) equals: diasDeTrabajo .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 19:40:56'!
test19diasDeTrabajoDeProyectoDeVariasTareasDeUnDesarrolladorInternoSonLosDiasDeTodasLasTareasQueHaceConSuperposiciones
	
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador diasDeTrabajo|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/2/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
	
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	"trabaja el 1, 2, 2,3"
	diasDeTrabajo:=OrderedCollection with:July/1/2024 with:July/2/2024 with:July/2/2024 with:July/3/2024.

	
	self assert: (desarrollador diasDeTrabajoEnProyecto: proyecto) equals: diasDeTrabajo .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 19:54:04'!
test20diasDeSobreasignacionDeProyectoDeUnDesarrolladorSinSuperposicionesEsUnaColeccionVacia
	
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/3/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
	
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).

	
	self assert: (desarrollador diasDeSobreasignacionEnProyecto: proyecto) equals: (Set new) .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 19:54:27'!
test21diasDeSobreasignacionDeProyectoDeUnDesarrolladorConSuperposicionesSonLosDiasDeSuperposicion
	
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/2/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
	
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).

	
	self assert: (desarrollador diasDeSobreasignacionEnProyecto: proyecto) equals: (Set with:July/2/2024) .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 20:03:07'!
test22costoTotalDeUnaTareaConUnDesarrolladorSonLosDiasDeTrabajoPorSuCostoPorDia
	
	|tareaConcreta desarrollador|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).

	
	self assert: (tareaConcreta costoTotal) equals: ((desarrollador costoPorDia) * 2) .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 20:16:23'!
test23costoTotalDeUnaTareaConUnEquipoEsLaSumaDeLosDiasDeTrabajoPorCostoPorDiaDeCadaDesarrollador
	
	|tareaConcreta desarrollador1 desarrollador2 equipo|
	
	desarrollador1:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	desarrollador2:= self desarrollador: 'Kuka' conDedicacion: (3*hour/day) costoPorHora: 2000*peso.
	
	equipo:= self equipoFormadoPor: (OrderedCollection with: desarrollador1 with:desarrollador2 ).
	
	tareaConcreta:= self tareaConcreta: 'SS A'
						ConResponsable: equipo
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).

	
	self assert: (tareaConcreta costoTotal) equals: ((equipo costoPorDia) * 2) .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/17/2024 20:21:12'!
test24costoTotalDeUnProyectoEsLaSumaDeLosCostosDeSusSubPartes
	
	|tareaConcreta1 tareaConcreta2 proyecto|
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Pepe' conDedicacion: 6*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/2/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: (self desarrollador: 'Ramon' conDedicacion: 8*hour/day costoPorHora: 100*peso)
						fechaInicioDeseada: July/1/2024
						esfuerzo: 8*hour
						dependientes: (OrderedCollection new ).
						
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).
	
	self assert: (proyecto costoTotal) equals: (tareaConcreta1 costoTotal + tareaConcreta2 costoTotal ) .! !

!ProjectTests methodsFor: 'tests' stamp: 'MAM 11/18/2024 13:58:25'!
test25worksheetDeUnProyectoConUnDesarrolladorIncluyeSobreasignacionesDiasDeSobreasignacionYCostoTotal
	|tareaConcreta1 tareaConcreta2 proyecto desarrollador worksheet diasDeSobreasignacion|
	
	desarrollador:= self desarrollador: 'Kuka' conDedicacion: (1*hour/day) costoPorHora: 1000*peso.
	
	tareaConcreta1:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/1/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
						
	tareaConcreta2:= self tareaConcreta: 'SS A'
						ConResponsable: desarrollador
						fechaInicioDeseada: July/2/2024
						esfuerzo: 2*hour
						dependientes: (OrderedCollection new ).
	
	proyecto:= self proyecto: 'Rock' formadoPor: (OrderedCollection with: tareaConcreta1 with: tareaConcreta2 ).

	worksheet:= Worksheet deProyecto: proyecto.
	diasDeSobreasignacion:= Dictionary new.
	diasDeSobreasignacion at: desarrollador put: (desarrollador diasDeSobreasignacionEnProyecto: proyecto).
	
	self assert: (worksheet tieneSobreasignaciones) equals: true .
	self assert: (worksheet diasDeSobreasignacion) equals: (diasDeSobreasignacion ).
	self assert: (worksheet costoTotal) equals: (proyecto costoTotal).! !


!ProjectTests methodsFor: 'instances' stamp: 'MAM 11/16/2024 13:40:03'!
desarrollador: nombreDeDesarrollador conDedicacion: horasDiariasDeTrabajo costoPorHora: ingresoPorHora
	^Desarrollador deNombre: nombreDeDesarrollador dedicacion: horasDiariasDeTrabajo costoPorHora: ingresoPorHora ! !

!ProjectTests methodsFor: 'instances' stamp: 'MAM 11/16/2024 15:35:03'!
equipoFormadoPor: coleccionDeIntegrantes
	^Equipo formadoPor:coleccionDeIntegrantes .! !

!ProjectTests methodsFor: 'instances' stamp: 'MAM 11/17/2024 16:25:22'!
proyecto: nombreDeProyecto formadoPor: coleccionDeSubpreyectosYTareas 
	^Proyecto deNombre: nombreDeProyecto formadoPor: coleccionDeSubpreyectosYTareas .! !

!ProjectTests methodsFor: 'instances' stamp: 'MAM 11/16/2024 13:41:04'!
tareaConcreta: nombreDeTarea ConResponsable: unResponsble fechaInicioDeseada: unaFecha esfuerzo: horasDeDedicacion dependientes: tareasDependientes
	^Tarea deNombre: nombreDeTarea responsable: unResponsble fechaInicioDeseada: unaFecha esfuerzo: horasDeDedicacion dependientes: tareasDependientes 
	! !


!classDefinition: #Responsable category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Responsable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Responsable methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/16/2024 18:56:32'!
diasDeTrabajoParaRealizarTareaDeHoras: horasDeTarea

	self subclassResponsibility! !


!Responsable methodsFor: 'tareas' stamp: 'MAM 11/17/2024 15:53:34'!
agregarTarea: unaTarea

	self subclassResponsibility! !


!Responsable methodsFor: 'costos' stamp: 'MAM 11/19/2024 16:48:36'!
costoDeTrabajarDias: unaCantidadDeDias 
	^(unaCantidadDeDias *(self costoPorDia )/day)! !

!Responsable methodsFor: 'costos' stamp: 'MAM 11/18/2024 14:07:17'!
costoPorDia
	self subclassResponsibility ! !


!Responsable methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 14:08:07'!
desarrolladores
	self subclassResponsibility ! !


!classDefinition: #Desarrollador category: #'ISW1-2024-1C-2doParcial'!
Responsable subclass: #Desarrollador
	instanceVariableNames: 'nombre dedicacion costoPorHora tareas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Desarrollador methodsFor: 'initialization' stamp: 'MAM 11/17/2024 15:53:02'!
initializeDeNombre: nombreDeDesarrollador dedicacion: horasDiariasDeTrabajo costoPorHora: ingresoPorHora
	tareas:= OrderedCollection new.
	nombre := nombreDeDesarrollador.
	dedicacion := horasDiariasDeTrabajo.
	costoPorHora := ingresoPorHora.! !


!Desarrollador methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/17/2024 19:53:38'!
diasDeSobreasignacionEnProyecto: proyecto
	|diasDeTrabajo|
	diasDeTrabajo:=self diasDeTrabajoEnProyecto: proyecto.
	^(diasDeTrabajo select:[:unDiaDeTrabajo| (diasDeTrabajo occurrencesOf: unDiaDeTrabajo)>1 ]) asSet.! !

!Desarrollador methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/17/2024 19:00:19'!
diasDeTrabajoEnProyecto: proyectoOTarea
	^proyectoOTarea diasDeTrabajoDelDesarrollador:self.
	"^(tareas includes:proyectoOTarea ) ifTrue: [proyectoOTarea diasDeTrabajo] ifFalse: [OrderedCollection new]."! !

!Desarrollador methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/16/2024 15:24:45'!
diasDeTrabajoParaRealizarTareaDeHoras: horasDeTarea
	^(horasDeTarea / dedicacion)ceiling .! !

!Desarrollador methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/18/2024 13:53:44'!
tieneSobreasignacionEnProyecto: proyecto
	^(self diasDeSobreasignacionEnProyecto: proyecto) isEmpty not.! !


!Desarrollador methodsFor: 'tareas' stamp: 'MAM 11/17/2024 15:53:34'!
agregarTarea: unaTarea
	tareas add:unaTarea .! !

!Desarrollador methodsFor: 'tareas' stamp: 'MAM 11/17/2024 19:12:07'!
formaParteDeTarea: unaTarea
	^tareas includes:unaTarea .! !


!Desarrollador methodsFor: 'costos' stamp: 'MAM 11/17/2024 20:11:03'!
costoPorDia
	^dedicacion*costoPorHora*day/hour.! !


!Desarrollador methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 13:49:21'!
desarrolladores
	^OrderedCollection with:self
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Desarrollador class' category: #'ISW1-2024-1C-2doParcial'!
Desarrollador class
	instanceVariableNames: ''!

!Desarrollador class methodsFor: 'instance creation' stamp: 'MAM 11/16/2024 18:52:34'!
deNombre: nombreDeDesarrollador dedicacion: horasDiariasDeTrabajo costoPorHora: ingresoPorHora 
	self assertDedicacionValida: horasDiariasDeTrabajo .
	self assertCostoPorHoraValido: ingresoPorHora .
	
	^self new initializeDeNombre: nombreDeDesarrollador dedicacion: horasDiariasDeTrabajo costoPorHora: ingresoPorHora ! !


!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 18:51:21'!
assertCostoPorHoraValido: costoPorHora
	^costoPorHora >0 ifFalse:[self signalCostoPorHoraNoPositivoError]! !

!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 16:14:13'!
assertDedicacionValida: horasDeTrabajo
	^horasDeTrabajo >0 ifFalse:[self signalDedicacionNoPositivaError]! !

!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 18:52:19'!
costoPorHoraNoPositivoErrorDescription
	^'El costo por hora del desarrollador debe ser positivo'! !

!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 16:11:06'!
dedicacionNoPositivaErrorDescription
	^'La dedicacion del desarrollador debe ser positiva'! !

!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 18:51:55'!
signalCostoPorHoraNoPositivoError
	^self error:self costoPorHoraNoPositivoErrorDescription! !

!Desarrollador class methodsFor: 'error messages' stamp: 'MAM 11/16/2024 16:19:31'!
signalDedicacionNoPositivaError
	^self error:self dedicacionNoPositivaErrorDescription! !


!classDefinition: #Equipo category: #'ISW1-2024-1C-2doParcial'!
Responsable subclass: #Equipo
	instanceVariableNames: 'integrantes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Equipo methodsFor: 'initialization' stamp: 'MAM 11/16/2024 15:36:05'!
initializeFormadoPor: coleccionDeIntegrantes 
	integrantes := coleccionDeIntegrantes.! !


!Equipo methodsFor: 'tiemposDeTrabajo' stamp: 'MAM 11/16/2024 15:42:28'!
diasDeTrabajoParaRealizarTareaDeHoras: horasDeTarea 
	^(integrantes collect:[:unResponsable|unResponsable diasDeTrabajoParaRealizarTareaDeHoras: horasDeTarea ]) max .! !


!Equipo methodsFor: 'tareas' stamp: 'MAM 11/17/2024 15:54:16'!
agregarTarea: unaTarea
	integrantes do:[:unResponsable| unResponsable agregarTarea: unaTarea].! !


!Equipo methodsFor: 'costos' stamp: 'MAM 11/17/2024 20:17:55'!
costoPorDia
	^integrantes sum:[:unIntegrante| unIntegrante costoPorDia].! !


!Equipo methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 13:51:39'!
desarrolladores
	|desarrolladores|
	desarrolladores:=OrderedCollection new.
	integrantes do:[:unSubResponsable|desarrolladores addAll:(unSubResponsable desarrolladores) ].
	^desarrolladores.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Equipo class' category: #'ISW1-2024-1C-2doParcial'!
Equipo class
	instanceVariableNames: ''!

!Equipo class methodsFor: 'instance creation' stamp: 'MAM 11/16/2024 15:35:44'!
formadoPor: coleccionDeIntegrantes 

	^self new initializeFormadoPor: coleccionDeIntegrantes ! !


!classDefinition: #Trabajo category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Trabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Trabajo methodsFor: 'fechas' stamp: 'MAM 11/17/2024 19:02:36'!
diasDeTrabajoDelDesarrollador: unDesarrollador

	self subclassResponsibility! !

!Trabajo methodsFor: 'fechas' stamp: 'MAM 11/18/2024 14:09:29'!
fechaDeFinalizacion
	self subclassResponsibility ! !

!Trabajo methodsFor: 'fechas' stamp: 'MAM 11/18/2024 14:09:13'!
fechaDeInicio
	self subclassResponsibility ! !


!Trabajo methodsFor: 'costos' stamp: 'MAM 11/18/2024 14:12:24'!
costoTotal
	self subclassResponsibility ! !


!Trabajo methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 14:12:39'!
desarrolladores
	self subclassResponsibility ! !


!classDefinition: #Proyecto category: #'ISW1-2024-1C-2doParcial'!
Trabajo subclass: #Proyecto
	instanceVariableNames: 'nombre subPartes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Proyecto methodsFor: 'initialization' stamp: 'MAM 11/17/2024 16:29:04'!
initializeDeNombre: nombreDeProyecto formadoPor: coleccionDeSubpreyectosYTareas 
	nombre := nombreDeProyecto.
	subPartes := coleccionDeSubpreyectosYTareas.! !


!Proyecto methodsFor: 'fechas' stamp: 'MAM 11/17/2024 19:30:55'!
diasDeTrabajoDelDesarrollador: unDesarrollador
	|diasDeTrabajo|
	diasDeTrabajo:= OrderedCollection new.
	subPartes do:[:unaLabor|diasDeTrabajo addAll:(unaLabor diasDeTrabajoDelDesarrollador: unDesarrollador) ].
	^diasDeTrabajo .! !

!Proyecto methodsFor: 'fechas' stamp: 'MAM 11/17/2024 16:36:17'!
fechaDeFinalizacion
	^(subPartes collect:[:unaLabor| unaLabor fechaDeFinalizacion ]) max! !

!Proyecto methodsFor: 'fechas' stamp: 'MAM 11/17/2024 16:34:04'!
fechaDeInicio
	^(subPartes collect:[:unaLabor| unaLabor fechaDeInicio ]) min! !


!Proyecto methodsFor: 'costos' stamp: 'MAM 11/17/2024 20:21:45'!
costoTotal
	^subPartes sum:[:unaLabor|unaLabor costoTotal ].! !


!Proyecto methodsFor: 'sobreasignaciones' stamp: 'MAM 11/18/2024 14:04:10'!
diasDeSobreasignacion
	|diasDeSobreasignacion|
	diasDeSobreasignacion := Dictionary new.
	self desarrolladores do:[:unDesarrollador| diasDeSobreasignacion at:unDesarrollador put:(unDesarrollador diasDeSobreasignacionEnProyecto: self)].
	^diasDeSobreasignacion ! !

!Proyecto methodsFor: 'sobreasignaciones' stamp: 'MAM 11/18/2024 13:38:20'!
tieneSobreasignaciones
	^self desarrolladores anySatisfy:[:unDesarrollador| unDesarrollador tieneSobreasignacionEnProyecto: self].! !


!Proyecto methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 14:02:11'!
desarrolladores
	|desarrolladores|
	desarrolladores:= OrderedCollection new.
	subPartes do:[:unaLabor|desarrolladores addAll:(unaLabor desarrolladores) ].
	^desarrolladores asSet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Proyecto class' category: #'ISW1-2024-1C-2doParcial'!
Proyecto class
	instanceVariableNames: ''!

!Proyecto class methodsFor: 'instance creation' stamp: 'MAM 11/17/2024 16:28:36'!
deNombre: nombreDeProyecto formadoPor: coleccionDeSubpreyectosYTareas 
	^self new initializeDeNombre: nombreDeProyecto formadoPor: coleccionDeSubpreyectosYTareas ! !


!classDefinition: #Tarea category: #'ISW1-2024-1C-2doParcial'!
Trabajo subclass: #Tarea
	instanceVariableNames: 'nombre responsable fechaInicioDeseada esfuerzo dependientes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Tarea methodsFor: 'initialization' stamp: 'MAM 11/16/2024 15:27:34'!
initializeDeNombre: nombreDeTarea responsable: unResponsble fechaInicioDeseada: unaFecha esfuerzo: horasDeDedicacion dependientes: tareasDependientes 
	nombre := nombreDeTarea.
	responsable := unResponsble.
	fechaInicioDeseada := unaFecha.
	esfuerzo := horasDeDedicacion.
	dependientes := tareasDependientes.! !


!Tarea methodsFor: 'fechas' stamp: 'MAM 11/17/2024 18:55:10'!
diasDeTrabajo
	|diasDeTrabajo|
	diasDeTrabajo := OrderedCollection new.
	(self fechaDeInicio to: self fechaDeFinalizacion ) do:[:aDay|diasDeTrabajo add:aDay].
	^diasDeTrabajo .! !

!Tarea methodsFor: 'fechas' stamp: 'MAM 11/17/2024 19:11:47'!
diasDeTrabajoDelDesarrollador: unDesarrollador
	^(unDesarrollador formaParteDeTarea: self) ifTrue: [self diasDeTrabajo ] ifFalse:[OrderedCollection new].! !

!Tarea methodsFor: 'fechas' stamp: 'MAM 11/16/2024 15:10:01'!
diasDeTrabajoNecesitados
	^responsable diasDeTrabajoParaRealizarTareaDeHoras: esfuerzo .! !

!Tarea methodsFor: 'fechas' stamp: 'MAM 11/16/2024 19:10:57'!
fechaDeFinalizacion
	^self fechaDeInicio next:(self diasDeTrabajoNecesitados - (1*day))! !

!Tarea methodsFor: 'fechas' stamp: 'MAM 11/17/2024 15:42:20'!
fechaDeInicio
	^dependientes inject: fechaInicioDeseada into:[:fechaDeInicio :unaTareaDependiente| fechaDeInicio max:(unaTareaDependiente fechaDeFinalizacion next)]! !


!Tarea methodsFor: 'desarrolladores' stamp: 'MAM 11/18/2024 13:47:51'!
desarrolladores
	^responsable desarrolladores.! !


!Tarea methodsFor: 'costo' stamp: 'MAM 11/17/2024 20:09:00'!
costoTotal
	^responsable costoDeTrabajarDias: (self diasDeTrabajoNecesitados ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tarea class' category: #'ISW1-2024-1C-2doParcial'!
Tarea class
	instanceVariableNames: ''!

!Tarea class methodsFor: 'instance creation' stamp: 'MAM 11/17/2024 15:51:53'!
deNombre: nombreDeTarea responsable: unResponsable fechaInicioDeseada: unaFecha esfuerzo: horasDeDedicacion dependientes: tareasDependientes 
	|tarea|
	
	tarea:= self new initializeDeNombre: nombreDeTarea responsable: unResponsable fechaInicioDeseada: unaFecha esfuerzo: horasDeDedicacion dependientes: tareasDependientes.
	
	unResponsable agregarTarea: tarea.
	
	^tarea .! !


!classDefinition: #Worksheet category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Worksheet
	instanceVariableNames: 'proyecto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Worksheet methodsFor: 'initialization' stamp: 'MAM 11/18/2024 13:30:32'!
initializeDeProyecto: unProyecto
	proyecto:= unProyecto .! !


!Worksheet methodsFor: 'sobreasignaciones' stamp: 'MAM 11/18/2024 13:59:10'!
diasDeSobreasignacion
	^proyecto diasDeSobreasignacion.! !

!Worksheet methodsFor: 'sobreasignaciones' stamp: 'MAM 11/18/2024 13:34:11'!
tieneSobreasignaciones
	^proyecto tieneSobreasignaciones! !


!Worksheet methodsFor: 'costos' stamp: 'MAM 11/18/2024 14:04:37'!
costoTotal
	^proyecto costoTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Worksheet class' category: #'ISW1-2024-1C-2doParcial'!
Worksheet class
	instanceVariableNames: ''!

!Worksheet class methodsFor: 'instance creation' stamp: 'MAM 11/18/2024 13:29:50'!
deProyecto: unProyecto
	^self new initializeDeProyecto: unProyecto.! !
