let (>>=) = Lwt.bind
let alert s = Dom_html.window ## alert(Js.string s)
let bound smin smax x =
  max smin x
  |> min smax

                  
let hash () =
  Dom_html.window ## location ## hash
         
let anchor () =
  let sub = Js.to_string (hash ()) in
  if String.length sub = 0 then 0
  else Scanf.sscanf sub "#%d" (fun x -> x)

let retreive_diapositives =
  Dom_html.document ## querySelectorAll(Js.string ".diapositive")
  |> Dom.list_of_nodeList

let cmin, cmax = 0, (List.length retreive_diapositives)-1
let cursor = ref (anchor ())

let set_hash () =
  Dom_html.window ## location ## hash <-
    Js.string (Printf.sprintf "#%d" (!cursor))

let display value elt =
  elt ## style ## display <- (Js.string value)


let append_label i e =
  let value =
    if i = 0 then Js.string "Hello !" 
    else Js.string (Printf.sprintf "%d/%d" i cmax)
  in
  let label = Dom_html.(createSpan document) in
  let textn = Dom_html.document ## createTextNode(value) in
  let _ = label ## classList ## add (Js.string "trace") in
  let _ = Dom.appendChild label textn in
  Dom.appendChild e label

let current_div () =
  (List.nth retreive_diapositives !cursor)
                  
let init_mask () =
  let _ = List.iter (display "none") retreive_diapositives in 
  let _ = display "flex" (current_div ())
  in List.iteri append_label (retreive_diapositives)
                    
let next_mask () =
  let _ = cursor := (bound cmin cmax (!cursor + 1)) in
  let _ = List.iter (display "none") retreive_diapositives
  in display "flex" (current_div ());
     set_hash ()

let prev_mask () =
  let _ = cursor := (bound cmin cmax (!cursor - 1)) in
  let _ = List.iter (display "none") retreive_diapositives
  in display "flex" (List.nth retreive_diapositives !cursor);
     set_hash ()

    
let keypress_evt () =
  let open Lwt_js_events in
  async_loop
    keyup
    Dom_html.document
    (fun e _ ->
     Lwt.return begin
         match (e ## keyCode) with
         | 39 -> next_mask ()
         | 37 -> prev_mask ()
         | _ -> ()
       end
      )        

let mouse_evt () =
  let open Lwt_js_events in
  async_loop
    mousewheel
    Dom_html.document
    (fun (e, (x, y)) _ ->
     Lwt.return
       begin
         if y > 0 then next_mask ()
         else prev_mask ()
       end
    )

let click_evt () =
  let open Lwt_js_events in
  async_loop
    mouseup
    Dom_html.document
    (fun e _ -> Lwt.return (next_mask ()))


let _ =
  init_mask ()
  |> ignore;
  keypress_evt ()
  |> ignore;
  mouse_evt ()
  |> ignore;
  click_evt ()
                  
