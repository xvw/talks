let alert s = Dom_html.window##alert(Js.string s)


let () = Router.start (fun () ->
    match [%routes] with
    | [%route "regex-(a|b)"] -> alert "a ou b"
    | [%route "int-{int}"] -> alert "test"
    | [%route "hello{string}"] -> alert "hello"
    | [%route "{float}-{int{bool}-{string}"] -> 
	  alert "youhou"
    | ""-> alert "Index"
    | _ -> alert "Page inconnue"
  )
