% Formation JavaScript (rapidement) et Node.js
% Arvato 2016
% Xavier Van de Woestyne

> L'objectif de ce document est de rapidement survoler ce qui a été vu 
> durant les 21 heures qui ont été alouées à la formation.  
> Lisez-bien les questions et tâchez d'y répondre du mieux que vous pouvez. 
> **Bonne chance** !

# Théorie

#### Expliquer en quelques lignes les différences entre let, var et const
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Expliquez en quelques lignes les caractéristiques de Node.js
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Quelle différence y a-t-il entre un thread et un processus
|  
|  
|  
|  
|  
|  

#### En quelle année JavaScript a-t-il été conçu, par quelle société et de quels sont ses langages d'inspiration
|  
|  
|  
|  

#### Comment éviter l'enfer des callbacks (2 méthodes minimum)
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Décrivez le principe d'un émetteur d'événement (et son utilité dans Node.js)
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Quel est le véritable nom d'une promesse
|  
|  

#### Pourquoi ce code n'a pas de sens

> On admet que toutes les variables sont créées correctement et qu'il n'est pas dans une boucle!

```javascript
dispatcher.emit('an_event');
dispatcher.on('an_event', function(){ console.log("FOO"); });

```
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Que fait cette fonction ? 

```javascript
let myFunction = function(elements) {
	elements.reduce((a,b) => a+b,'');
}
``` 
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Dans les routes express, que sont respectivement `req` et `res` (types et rôle)
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Expliquez pourquoi Express rend le développement d'application web plus productif
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Qu'est-ce qu'un prototype en JavaScript
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Que renvoie require
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Donnez un cas pratique d'un émetteur d'événements et l'intérêt de son usage
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Pourquoi en Node.js ne doit-on pas se soucier des mutexes et des sémaphores
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Qu'est-ce que réellement une classe en JavaScript
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Qu'apporte les fat-arrows
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Que permettent les mixins
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Quelle méthode utiliser pour rédiriger le flux A vers le flux B
|  
|  
|  
|  
|  
|  
|  
|  
|  


# Pratique

#### Implémentez ces fonctions de manière élégante
```javascript

// array.forOne(f) : renvoie true si pour au moins
// 1 element de array, f(x) renvoie true. Renvoie 
// false sinon
Array.prototype.forOne = function(f) {






}

// array.forAll(f) : renvoie true si pour
// tous les elements de array, f(x) renvoie true.
// Renvoie false sinon
Array.prototype.forOne = function(f) {






}

// array.for3(f) : renvoie true si pour au moins
// 3 elements de array, f(x) renvoie true. Renvoie 
// false sinon
Array.prototype.for3 = function(f) {






}

// array.zeroOrMore(f) : renvoie true si pour au moins
// 0 element de array, f(x) renvoie true. Renvoie 
// false sinon
Array.prototype.forOne = function(f) {






}


```

#### Implémentez un serveur qui affiche Hello World sur toutes les pages, sans express
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Implémentez un serveur via Express qui expose la route `hello` qui renverra le Json `{'hello for` : "the world"} et la route `hello/:name` qui renverra le Json `{'hello for' : name}`
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  

#### Ecrivez un package.json pour cette dernière application
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  
|  

# FIN

Merci à tous pour cette formation ! Bonne continuation dans l'apprentissage de Node.js, c'était très édifiant (pour moi) et votre intérêt fût très plaisant. Bravo d'avoir emmagasiner autant d'informations en si peu de temps !
