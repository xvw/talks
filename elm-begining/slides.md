% La gentille introduction à Elm
% ![](images/logo.png){width=80px}
% Raphaël Pallies, Xavier Van de Woestyne \newline \newline LilleFP3

# Intro : A supprimer

-  Web et JS (ici on troll React and co, complexité)
-  Elm : Un langage pour le web (Types, FRP)
-  Let it be Mainstream
-  Elm Architecture
-  Modules

# Flash, JavaScript, Silverlight (:troll:)

![Puis bon, Flash et Silverlight... ahem](images/evolution.jpeg){width=320px}

---

## Maintenant on veut :

- Des Single-page-app's ;
- super réactive ;
- responsives ;
- sans temps de chargements (fait par le serveur) mais par des *spinners*.

---

![Pleins d'outils](images/js.jpeg)

---

![Sans troll hein](images/react.png)

# Elm in a nutshell

Créé par **Evan Czaplicki** en 2012

- Langage fonctionnel (réactif), statiquement typé et concurrent;
- qui compile vers JavaScript (comme d'autres) ;
- des erreurs expressives ;
- accessible et performant ;
- utilisé industriellement ;
- interdisant (au mieux) les erreurs au *Runtime* ;
- facile à apprendre ;
- respectant la tradition des langages **ML** (et proche de Haskell).


---

![Yep, vraiment ML-inspired !](images/evan.png)

---

> Issu de la recherche mais évoluant grâce à la communauté.

# Typé statiquement

- Types primitifs (liste, nombres, booléens, chaines de caractères etc.) ;
- polymorphisme paramétrique ;
- types algébriques ;
- alias de types.

`direBonjour : String -> String -> Html.text`

`direBonjour : Prenom -> Nom -> Html.text`


# Installation

- Via des *installers* (site officiel) ;
- via NPM :

```shell
       npm install -g elm
```

L'installation offre :

-  `elm-repl` ;
-  `elm-reactor` ;
-  `elm-make` ;
-  `elm-package`.

# Elm-repl

> Une boucle interaction pour tester des expressions Elm rapidement.


```shell
---- elm-repl 0.18.0 ------------------
 :help for help, :exit to exit, more at ...
---------------------------------------
> 1 + 1
2 : number
> List.foldl (+) 0 [1, 2, 3, 4, 5]
15 : number
>
```

# Elm-reactor

- Aide à la construction d'un projet Elm ;
- permet de lancer un serveur de test ;
- permet d'explorer les fichiers Elm ;
- recompile à chaque actualisation.

## Un Hello world en Elm

```haskell
import Html exposing (text)
main =
  text "Hello, World!"

```

# Utilisation de la Elm-architecture

## Programme
> Un programme cristallise la Elm-architecture,
> il représente le cycle de vie de l'application et
> son mécanisme de communication.

### Beginner programme

```haskell
beginnerProgram :
    {
        model : model,
        view : model -> Html msg,
        update : msg -> model -> model
    } -> Program Never
```

---

- Un programme est généralement le point d'entrée d'une application ;
- il existe d'autre programme plus fins.

> Le *beginnerProgram* exprime une idée simple de la Elm-architecture. Chaque
> interaction (clique par exemple) du programme produit **un message**. Le message
> est envoyé à **l'update** qui, sur base du **modèle** courant, produit un nouveau
> modèle. **La vue** se regénère sur base du nouveau modèle. Ces actions se répètent
> indéfiniment.


# Représentation du HTML avec des fonctions

-  `tag [attr_list] [children_list]` : tag normal ;
-  `text "mon texte"` : noeud textuel (PCDATA).

# Live-coding !

-  Un compteur réactif,
-  une liste de présentations !

> Gros gros challenge, effet **WHAOU** garantit.

# History : déboguer vos programmes Elm

-  Permet de rejouer des états de l'application ;
-  permet d'observer le modèle à des états donnés ;
-  permet d'importer/exporter des collections d'états. (Génial pour demander (ou prodiguer) de l'aide !)

# Ecosystème et communauté

-  Elm-package : gestionnaire de paquet de Elm ;
-  Awesome-elm : liste de ressources Elm ;
-  beaucoup de tutoriels/exemples ;
-  beaucoup d'intégrations dans des éditeurs ;
-  Elm-test ;
-  Elm-format (un peu extrême) ;
-  Elm-router, Elm-Lazy etc.


# Outro : a supprimer

-  Point forts (+héritage)
-  Points faibles (modules)
-  Future (PureScript)
-  Conclusion
