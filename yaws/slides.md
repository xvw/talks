% Yaws : Yet Another Web Server
% Xavier Van de Woestyne ~ @derniercriio
% `(Lille |> Elixir) 3`

# WHOAMI

-  **@vdwxv** sur Twitter, **@xvw** sur Github ;
-  Erlang, OCaml, Elixir, Ruby etc. ;
-  Développeur à **Dernier Cri** ;
-  *LilleFP*.


---

> Qui a de l'expérience dans le tuning de **BEAM** et de **OTP** et du *Lexer* **Erlang** ?

---

![Ouf, moins de 4 personnes !](schemas/burns.jpg){width=390px}

---

# Sommaire

## Objectif

> Faire une brève présentation des outils Erlang !

## Plan

-  **Erlang** et le web (Cowboy + blablabla) ;
-  présentation formelle de Yaws ;
-  applications structurées avec modernité et **Appmode** ;
-  et dans le futur ;
-  conclusion.

# "Erlang is the DSL for writing (web) servers" \newline @pavlobaron

- Concurrent ;
- la VM peut transformer les interactions avec des sockets en envois de messages ;
- `gen_(...)` et `inets`.

> On peut imaginer écrire un serveur en ~40 lignes de codes.

# Et comment tenir la montée en charge ?

-  `gen_server`
-  `supervisor`
-  `application` (pour la *bogossitude*)

> C'est tellement simple qu'il existe des *milliers* de serveurs (web) sur les internets !

---

- Elli ;
- Cowboy ;
- Yaws ;
- MochiWeb ;
- Misultin ;
- ...

![aha](schemas/meme.jpg){width=200px}


# Cowboy, le choix de Phoenix !

En vrai, Cowboy n'est **pas** un serveur HTTP(s) ...

- Bibliothèque *Low-level* ;
- discutablement composable ;
- très efficace ;
- facile à prendre en main.

> C'était un choix qui s'inscrivait vraiment bien dans la *vibe* de **Phoenix** !

# Les apports de Cowboy dans le monde Erlang

-  Une culture de la bibliothèque spécialisée ;
-  une véritable culture de l'usage des *high-order-function* (sans troll) ;
-  de l'agilité (facile à maintenir et tout) !


-  Phoenix...

# Pendant ce temps là, en 2001, Yaws !

-  @klacke (Claes Wikstrom) ;
-  2001, des compétitions de **Floorball** ;
-  le web comme **medium**, hors de question d'utiliser PHP !

> "I was absolutely struck with horror when I finally realized how horrible the LAMP stack was, and in particular the ugliness of the PHP language.”

**@Klacke** (en 2001)

# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !

# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !
-  `eprof`

# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !
-  `eprof`
-  `ets` et `dets`

# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !
-  `eprof`
-  `ets` et `dets`
-  `Mnesia`

# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !
-  `eprof`
-  `ets` et `dets`
-  `Mnesia`
-  Erlang Bit Syntax


# Who is Klacke ?

-  ASN.1 Compiler (le **king** de 1988) !
-  `eprof`
-  `ets` et `dets`
-  `Mnesia`
-  Erlang Bit Syntax
-  Erlang distribué

# Yet Another Web Server :

- Un serveur embarqué ou *stand-alone* ;
- **Hyper** stable et distribuable !

## Perf (req/sec)

- `> Apache`
- `> Nginx`
- `> Cowboy`

## Utilisateurs

WhatsApp, Klarna entre autres.

# Yaws KESAKO

- HTTP 1.1
- URL/#arg rewriting
- SSL support
- cookie/session support
- munin stats
- CGI and FCGI
- forward and reverse proxies
- file upload
- WebDAV
- small file caching
- SOAP support
- haXe support
- ehtml and exhtml
- virtual directories
- configurable deflate
- ACLs
- precompressed static files • configurable MIME types

---
- JSON and JSON-RPC 2.0
- WebSocket support
- GET/POST chunked transfer
- streaming
- multipart/mime support
- PHP handling via FCGI
- server-side includes
- heart integration
- both autoconf and rebar builds
- logging in Apache common format
- virtual servers
- man pages and LaTex/PDF docs
- **JIT-compiled - yaws pages**
- **Server-Sent Events**
- **appmods**
- **yapps**

# Appmod et Yapps

- Arrêter de faire comme *Apache* ;
- percevoir le *framework* comme une brique logicelle ;
- avoir de belles URL's.

# Bénéfices de Yaws

- De la performance de **OUF** ;
- le serveur du futur (sans troll, **Ocsigen blahblah**) ;
- si vous avez envie de faire du HaXe !

# Et pour Elixir ?

- Un port de Yaws pour Elixir (et éventuellement Phoenix) ie: @Hyperaho ;
- Elixir et Erlang sont Iso's, pourquoi est-ce compliqué ?

# Conclusion

- Les besoins réels, via **Elixir**, pour construire une API ? (Plug, Ecto) ;
- **self-contained applications** ;
- LE FUTUUUUUR ?


# Questions ?

-  Elixir et Yaws ?
-  Cowboy ?
-  OCaml :D
