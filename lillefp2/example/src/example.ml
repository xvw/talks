let alert s = Dom_html.window##alert(Js.string s)

let () = Router.start (fun () ->
    match [%routes] with

    | [%route "hello-{string}"] ->
      let nom = route_arguments () in
      alert ("Hello " ^ nom)

    | [%route "age-{int}-nom-{string}"] ->
      let age, nom = route_arguments () in
      alert (Printf.sprintf "Hello %s, tu as %d ans" nom age)
      
    | ""-> alert "Index"
    | _ -> alert "Page inconnue"
  )

