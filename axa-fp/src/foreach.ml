(* Listes : [1; 2; 3] == 1 :: 2 :: 3 :: [] *)

let rec foreach list f =
  match list with
  | [] -> ()
  | x :: xs -> f x ; foreach xs f

let () = foreach [1; 2; 3] print_int
