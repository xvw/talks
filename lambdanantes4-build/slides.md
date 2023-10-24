---
title: les **systèmes de construction** (_build system_)
author: Xavier Van de Woestyne - xvw.lol
subtitle: Théorie informelle et pratique
header-includes: |
  \usepackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{arrows}
...

> Un _build system_ est un logiciel (ou une collection de logiciels) permettant
> d'automatiser certaines tâches récurrentes. Par exemple produire des artefacts
> (compilation, unités, _typechecking_, documentation), exécuter des tests,
> _linter_.

# Pourquoi s'y intéresser ?

- Ce sont des logiciels invasifs dans notre métier que l'on comprend souvent mal ;
- je trouve que c'est un sujet intéressant (pour lequel l'approche théorique est
  récente) ;
- ça permet de comprendre les limites (et les _trade off_) de certains (`cabal`,
  `dune + opam`, `maven`) ;
- diminués, ils permettent de solutionner des problèmes usuels (par exemple,
  décrire un générateur de blogs statiques).

# Plan

- Origine de mon intérêt pour les _build systems_ ;
- Une brève frise chronologique ;
- Implémentations et considérations
- Conclusions

# Un intérêt subite grâce à Preface !

> Preface is an opinionated library designed to facilitate the handling of
> recurring functional programming idioms in OCaml.\newline \newline Par [Didier
> Plaindoux](https://github.com/d-plaindoux), [Pierre
> Ruyter](https://github.com/gr-im), [Michaël Spawn](https://github.com/mspwn),
> moi et d'autres contributeurs occasionnels\newline

- Une bibliothèque _pour programmer comme en Haskell_
- conçue à des fins pédagogiques
- après un premier usage sur un projet personnel\pause
- **inutilisable sur beaucoup d'aspects**\newline\pause

C'est pour ça que **YOCaml** a été conçu: **expérimenter l'expérience
utilisateur** de Preface avec un projet qui utilise des abstractions un peu
moins populaires dans _le monde des blog-posts_.

#

Ce qui explique parfois **des choix relativement peu pragmatiques**.
\newline\newline\pause Parce que pour **expérimenter l'expérience utilisateur**
de Preface, nous avons conçu un outil à **l'expérience utilisateur
douteuse**...\newline\pause

Mais après un an, YOCaml est un peu utilisé et certains (dont moi) en sont même
satisfait ! Et YOCaml est un **tout petit build system** qui utilise un encodage
élégant à base de _Profunctors_.

# Au même moment

Sortie des papiers suivants:

## Build systems à la carte

Par **A. Mokhov**, N. Mitchell, S. P. Jones

> Une tentative convaincante de formalisation des Build Systems avec une souche
> théorique robuste. \pause

## Selective Applicative Functors

Par **A. Mokhov**, G. Lukyanov, S. Marlow, J. Dimino

> L'ajout d'une abstraction entre Applicative et Monad qui complète la
> hiérarchie des abstractions de kind d'artité 1 (et qui fournit une
> contrepartie à Arrow Choice). \pause \newline\newline

Mokhov a été un relecteur consciencieux de la partie Selective (et Free/Freer
selective) de Preface.

# Sur l'utilisation des la théorie des catégories

**Schéma sarcastique :**

- **Fresh Haskell Programmer** : ne comprends rien à la théorie des catégories
  et l'évite \pause
- **Haskell Programmer** : ne comprends rien à la théorie des catégories et veut
  en mettre partout et trouve la programmation _tacite_ jolie\pause
- **Experimented Haskell Programmer** :capture les idées derrière la théorie des
  catégories et argue que ça ne sert à rien pour être un développeur (-> Boring
  Haskell)\pause
- **Haskell Superstar** : utilise la théorie des catégories pour décrire des
  formalismes et potentiellement faire des optimisations non triviales.\pause\newline

> Le dernier point est intéressant.

---

## A Categorical Theory of Patches

Par S. Mimram, C. Di Giusto

> Une approche catégorique de l'application de patches dans le contexte **des
> systèmes de gestion de versions** \pause\newline

- Utilisés par **Darcs** et plus recemment par **Pijul**
- une approche **très convaincante**

---

_Build Systems à la carte_ explore une approche similaire : \pause

- une mise à plat terminologique ; \pause
- une capture concrète des abstractions liées à un _Build System_ ; \pause
- une classification des différents types de _Build System_ ; \pause
- des proposition catégoriques (moins lourdes que dans la théorie des patches) ;
  \pause\newline\newline

> Ici je dois donner un peu d'informations sur les papiers "dit à la Carte" (désolé, je ne sais pas comment faire des speakers notes. **Lol**)

---

La théorie des catégories permet plusieurs choses : \pause

- programmer avec des mots savants ; \pause
- _over engineer_ beaucoup de choses ; \pause
- fournir parfois des modèles de résolutions de problèmes élégants ; \pause
- construire des intuitions et des formalismes sur des problèmes complexes.

# Au début, après les scripts, il y eut `Make`

- **La genèse** : des collections de scripts pour automatiser ; \pause
- **1976** : Make (simple et utile) \pause

```make
%.x : %.y
  task list
```

\pause

- Une révolution
- générique et agnostique
- très facile à prendre en main.

---

```make
all: main.exe

lib.cma: libA.ml libB.ml
    ocamlc libA.ml libB.ml -o lib.cma

main.cmo: libB.ml main.ml
    ocamlc libB.ml main.ml -o main.cmo

main.exe: lib.cma main.cmo
    ocamlc lib.cma main.cmo -o main.exe
```

---

![le treillis formé par make](fig/make-1.png){ width=250px }

---

![si l'on modifie libB.ml](fig/make-2.png){ width=250px }

---

![si l'on modifie main.ml](fig/make-3.png){ width=250px }

# Les points faibles de Make

- Les dépendances ne peuvent qu'être statiques \pause
- elles doivent être répétées \pause
- la stratégie de nettoyage est laborieuse \pause
- son côté agnostique le rend difficile pour certaines tâches spécialisés \pause
- logiciel ancien qui ne tient pas compte des évolutions (cloud build etc.)

# Idiomes relatifs aux _Build Systems_ : la minimalité

> Un système de construction est minimal si il n'exécute que les tâches
> nécéssaires une seule fois et si il dépend transitivement des _entrées_ ayant
> changées depuis la construction précédente. \pause\newline

## Pour atteindre la minimalité

- `Make` repose sur la `date de modification` d'une entrée
- et construit un graphe de dépendance de tâches basé sur **un ordre topologique**

# Construction d'un système assurant la minimalité

## Description des dépendances

Basé sur un Set de chaine de caractères :

```ocaml


type t

val empty : t
val of_list : filepath list -> t
val singleton : filepath -> t
include Preface.Specs.MONOID with type t := t


```

- `neutral` = `set vide`
- `concat` = `union` de deux sets.

---

## Requêter un ensemble de dépendances

On voudrait savoir si une cible doit être modifiée selon un ensemble de
dépendance. En d'autres mots: \pause

- Si la cible n'existe pas, **on doit la créer** \pause
- Si la cible existe mais: \pause
  - sa date de modification inférieure à une des dates de modification des
    dépendances, **on doit la créer** \\pause
  - sa date de modification supérieure à toutes les dates de modification des
    dépendances, **on ne doit pas la créer**

---

```ocaml
module Traverse = List.Monad.Traverse (Impure)
let get_mtimes list =
   List.map Impure.get_mtime list
```

\pause

```ocaml
  (* get_mtimes : filepath list -> int Impure.t list  *)
```

\pause

```ocaml
  |> Traverse.sequence
  (* get_mtimes : filepath list -> int list Impure.t  *)
```

---

On peut maintenant décrire une fonction qui requête un set de dépendances pour
savoir s'il est nécessaire de reconstruire un fichier. \pause

```ocaml
(* need_update : Deps.t -> filepath -> bool Impure.t *)
```

\pause

```ocaml
let need_update deps target =
    let open Impure in
    let* exists = file_exists target in
    if not exists then return true
    else
      let* target_time = get_mtime target in
      let+ deps_times = get_mtimes (S.elements deps) in
      List.exists (fun deps_time -> deps_time > target_time) deps_times
```

\pause

Dans les grandes lignes, c'est comme ça que `make` fonctionne.

# On pourrait décrire un tâche comme étant un Applicative :

```ocaml
type 'a t = {
  deps: Deps.t
; task : 'a Impure.t }

```

---

```ocaml

type 'a t = { deps : Deps.t; task : 'a Impure.t }

module Applicative = Preface.Make.Applicative.Via_pure_and_apply (struct
  type nonrec 'a t = 'a t

  let pure x = { deps = Deps.empty; task = Impure.return x }
```

\pause

```ocaml
  let apply fa xa = {
    deps = Deps.combine fa.deps xa.deps
  ; task = Impure.Applicative.apply fa.task xa.task }
  end)
```

\pause

```ocaml
  let read_file filename =
    { deps = Deps.singleton filename
    ; task = Impure.read_file filename }
end
```

---

```ocaml
let write_file target rule =
  let open Impure in
  let* need_update = Deps.need_update rule.Task.deps target in
  if need_update then
    let* content = rule.task in
    write_file target content
  else return ()
```

---

On peut décrire cette règles `make` :

```make
page.html: header.html content.html footer.html
  cat header.html content.html footer.html > page.html
```

---

```ocaml
let a_task =
  let open Task.Applicative in
  let+ header = Task.read_file "header.html"
  and+ content = Task.read_file "content.html"
  and+ footer = Task.read_file "footer.html" in
  header ^ content ^ footer
```

\pause

```ocaml

{ task = ...
; deps = ["content.html"; "footer.html"; "header.html"]
} - string Task.t
```

\pause

```ocaml

let page_html = write_file "page.html" a_task
```

---

On est même supérieur à `make` car on ne doit pas répéter les dépendances.

---

## Par contre, comme pour `make` :

- on peut tracker que des dépendances statiques
- chaque fragment est calculé indépendament \newline

\pause

## Application partielle VS application séquentielle

```ocaml
f <$> a <*> b <*> c <*> d
a >>= f >>= g >>= h >>= i


```

> Que peut-on spéculer sur ces deux lignes ?

# Build System Applicatif VS Build System Monadique

On peut décire un build système monadique en remplaçant l'utilisation de `apply` par `bind` (ou `flat_map`). La différence principale réside dans : \pause

- Un build système applicatif exécute chaque tâches indépendament et les groupes
  à la fin, on peut donc faire des **spéculations sur des composants statiques**,
  comme les dépendances. ie: `make` \pause
- Un build système monadique construit une séquence dépendante entre les
  différentes tâches, il n y a donc pas de composants statiques par contre, ils
  peuvent **construire des dépendances dynamiquement** . ie: `Excell` (qui est
  aussi un build-system) \pause

---

```ocaml
#include "my_file.ml" ;;
let main () = ...
#include "termination.ml" ;;


```

`my_file.ml` et `termination.ml` sont des dépendances dynamiques, il faut lire
le fichier pour les déduires.

---

- Nécéssaire pour construire des `build-systems` du monde réel (ou des générateurs de blog statique, pour permettre de faire des indexes de pages par exemple)
- rend l'approche de la **minimalité** (beacoup) plus complexe.

# Approcher les dépendances statiques ET dynamiques

```ocaml
let dynamic_deps_example target =
   let open Dynamic in
   let* dynamic_comp = read_in_cache target <*? read_deps in
   let task =
     let+ header = Task.read_file "header.html"
     and+ content = Task.read_file "content.html"
     and+ footer = Task.read_file "footer.html" in
     header ^ content ^ footer
    in write_file_with_dynamic_comp dynamic_comp task target
```

\pause

```ocaml
val ( <*? ) :
    ('a, 'b) Either.t Task.t
 -> ('a -> 'b) Task.t
 -> 'b Task.t
```

---

- `<*?` est l'opérateur `select` d'un foncteur selectif Applicatif \pause
- En fonction de ce que renvoie la première fonction, il va exécuter la seconde où non \pause
- Accouplé à un **cache** on peut ne pas relire inutilement un fichier. \pause

\pause

```ocaml
(* val read_in_cache : filepath -> (unit, Deps.t) Either.t *)
let read_in_cache target =
    if file_is_updated file then Left ()
    else Right (get_deps_from_cache_for target)
```

\pause

- `read_deps` ne sera appliquée que si la cible a été modifiée.

# Foncteur Selective Applicative

- Se situe entre Applicative et Monade\pause
- Permet de conditionner l'exécution de la tâche suivante en fonction du
  résultat de la précédente (sans partager le résultat) \pause

![table](fig/table.png)

# Complément, Approxmation

Dans le mondes des Applicatives (et des Foncteurs), il existe un monoïde particulier (le _monoide fantôme_), `Const` pour lequel il n'existe pas d'instance de Monade mais qui offre des capacité d'analyse intéressantes : \pause

```ocaml
module Const (M : Preface.Specs.MONOID) = struct
  module Applicative = Preface.Make.Applicative.Via_pure_and_apply (struct
    type 'a t = M.t

    let pure _ = M.neutral
    let apply x y = M.combine x y
  end)
end
```

---

En fonction de l'implémentation de `select` une **transformation naturelle**
peut permettre de calculer deux types d'approximation d'exécutions de tâches :

---

```ocaml
module Under =
    Preface.Make.Selective.Over_applicative_via_select
      (Applicative)
      (struct
        type 'a t = M.t

        let select x _ = x
      end)
```

---

```ocaml
module Over =
    Preface.Make.Selective.Over_applicative_via_select
      (Applicative)
      (struct
        type 'a t = M.t

        let select = Applicative.apply
      end)
```

---

Par exemple en admettant un `if` et un `when` selectifs:

```ocaml
val if_ : bool Task.t -> 'a Task.t -> 'a Task.t -> 'a Task.t
val when_ : bool Task.t -> unit Task.t -> unit Task.t
```

---

```ocaml
let r =
  let open Const.Over in
  let x = if_ (over "a") (over "b") (over "c") in
  x *> (over "d") *> when_ (over "e") (over "f")

# over "abcdef"

```

\pause

`Over` collecte **toutes les tâches pouvant être exécutées**.

---

```ocaml
let r =
  let open Const.Under in
  let x = if_ (under "a") (under "b") (under "c") in
  x *> (under "d") *> when_ (under "e") (under "f")

# under "ade"

```

\pause

`Under` collecte **toutes les tâches qui vont obligatoirement se produire** (il
évince les effets conditonnels)

---

- `Over` peut être utile, par exemple, pour installer toutes les `dépendances` possibles avant de lancer le _build_ (dans le contexte, par exemple d'un _package manager_)
- `Under` donne exhaustivement les points de parallèlisme possible d'une
  séquence de build. Toutes les tâches `sous-approximés` peuvent être
  parallèlisées.

# Pour conclure

Le papier _Build Systems à la Carte_ présente beaucoup plus de cas d'analyses
qui sont mises en pratiques dans les systèmes `dune` et `buck2`.

- Il vaut la peine d'être lu et j'en ferai surement un article de vulgarisation
  sur mon blog
- Il est possible de modeliser tout ce qui est présenté avec des `Arrows` (où
  `Choice` = `Selective`)
- Désolé pour la préparation un peu à la hâte.

---

## Questions ou remarques ?
