-------------------Introduction--------------------
J'ai réalisé un jeu de combat en 2D avec le langage Lua et le Framework Love2D. 
J'ai programmé ce jeu avec l'IDE ZeroBrane Studio. Pour les graphismes du jeu, 
j'ai utilisé les graphismes de StreetFighter 2.


-----------Fonctionnement du jeu---------------

 	---menu---
	---------

Dés qu'on lance le projet, on arrive directement sur l'écran de menu.
On peut changer la sélection de l'un des items(situé en bas à droite de l'écran) en
utilisant les flèches Up et Down du clavier. Pour activer l'item sélectionné on
peut appuyer sur la touche entrée du clavier.


	---choix du personnage----
	---------------------------

Si on a choisi l'item "Play" dans le menu, on arrive ensuite sur l'écran pour
choisir le personnage que l'on veut incarner pour le combat.

Si vous voulez revenir en arrière et que vous n'avez pas encore sélectionné de personnage,
cliquez sur la touche entrée du clavier et vous retournerez dans le menu.

Pour choisir notre personnage, il suffit de bouger le carré de sélection(carré rouge
entourant l'un des personnages) de gauche à droite ou de droite à gauche en appuyant
sur les flèches Left et Right du clavier.
Une fois notre choix fait, on peut sélectionner le personnage choisi en appuyant 
sur la touche "A" du clavier.

Si vous voulez changer votre choix alors que vous avez déjà sélectionné votre 
personnage. Vous pouvez cliquer sur la barre espace du clavier pour revenir en 
arrière et choisir un autre personnage.

Si vous voulez passer à la suite et que vous êtes sur de votre choix, alors 
il suffit de cliquer sur la touche entrée du clavier.



	-----Jeu-----
	-------------
On ce retrouve ensuite sur l'écran de jeu pour commencer le combat.

Notre personnage est à gauche de l'écran et notre adversaire ce trouve à droite de
l'écran (en début de round).
L'adversaire a été choisi au hasard entre tous les personnages (sauf celui que vous
incarnez) qui existent dans la bibliothèque de personnages que vous avez vu sur 
l'écran de choix de personnage.

Le combat commence une fois le compte à rebourd terminé. Il y aura trois rounds. Le
personnage qui gagnera le plus de rounds sera le gagnant.

Les barres de vie des personnages ce trouvent en haut de l'écran de jeu, avec les 
noms des combattants inscrits en dessous de leurs barres de vies respective.

	--déplacement de l'adversaire--
L'adversaire ce déplace tout seule et porte des coups de manière aléatoire quand il
est à une certaine distance de notre personnage grâce a une Intelligence
Artificielle.

	---déplacement de notre personnage--
On peut déplacer notre personnage de gauche à droite avec les flèches Left et Right
du clavier.
	
	[fausse 3D]
On peut aussi déplacer notre personnage de haut en bas avec les flèches Up et Down 
du clavier. Dans ce cas, notre personnage n'est plus en face de son adversaire et
donc notre personnage ne peut plus frapper l'adversaire et l'adversaire ne peut plus
lui aussi frapper notre personnage.

Ce déplacement sert à passer derrière ou devant notre adversaire, pour le dépasser et
aller de l'autre côté de l'écran. Attention pour y arriver, il faut que notre 
personnage soit bien devant ou derrière son adversaire (bien a la limite où il 
peut aller en haut ou en bas).

C'est qu'une fois qu'on à dépasser notre adversaire et qu'on retourne en face de 
celui-ci que le combat peut continuer. 
     	

Pour porter un coup à notre adversaire il faut cliquer sur une combinaison de touches.
Pour connaître la combinaison de touches qui correspond aux coups que l'on veut porter,
il faut appuyer sur la touche "A" du clavier.

Une fois qu'on a cliquer sur la touche "A" du clavier, le jeu ce met en pause et 
un petit écran s'affiche. Sur ce petit écran, il y a les combinaisons des touches
avec les coups correspondant affiché en face.
Si vous voulez reprendre le jeu, il suffit d'appuyer de nouveau sur "A".


Quand on arrive a frapper notre adversaire, il perd de la vie. Si c'est notre 
adversaire qui nous frappe alors c'est notre personnage qui perd de la vie. La
vie qui nous reste ou la vie qui reste à notre adversaire est visible en regardant
les barres de vies.

Quand un des deux combattants n'a plus de vies, le round est terminé. Si il nous
reste des rounds a effectuer, le jeu continue. Si on a effectué les 3 rounds alors le
combat est terminé et le gagnant est désigné avec une animation. Une fois cette animation
terminé, on retourne automatiquement dans le menu.
