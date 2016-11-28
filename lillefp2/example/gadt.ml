module VList =
struct

 type ('a,'b) t =
    | [] : ('b, 'b) t
    | (::) : 'c * ('a, 'b) t -> ('c -> 'a, 'b) t

end

  (* WTF, une liste une hétérogène en OCaml *)
let li = VList.[1; "deux"; true]
