type (_, _) eq = Refl : ('a, 'a) eq

let symmetry (type a b) : (a, b) eq -> (b, a) eq = fun Refl -> Refl
let symm (type a b) (Refl : (a, b) eq) : (b, a) eq = Refl

let transitivity (type a b c) : (a, b) eq -> (b, c) eq -> (a, c) eq =
 fun Refl Refl -> Refl
;;

let trans (type a b c) (Refl : (a, b) eq) (Refl : (b, c) eq) : (a, c) eq =
  Refl
;;

let cast (type a b) : (a, b) eq -> a -> b = fun Refl x -> x
let cast (type a b) (Refl : (a, b) eq) (x : a) : b = x

module For (T : sig
  type 'a t
end) =
struct
  let up (type a b) : (a, b) eq -> (a T.t, b T.t) eq = fun Refl -> Refl
end

module T : sig
  type t

  val eq : (int, t) eq
end = struct
  type t = int

  let eq = Refl
end

let x : (int, T.t) eq = T.eq

class ['a] olist_1 (l : 'a list) =
  object
    val value = l
    method length = List.length l
    method append other = {<value = List.append value other>}
    method map : 'b. ('a -> 'b) -> 'b list = fun f -> List.map f value
  end

class ['a] olist_2 (l : 'a list) =
  object
    val value = l
    method length = List.length l
    method append other = {<value = List.append value other>}

    method map : 'b. ('a -> 'b) -> 'b olist_1 =
      fun f -> new olist_1 (List.map f value)
  end

class type ['a] clist =
  object ('self)
    method length : int
    method uncons : ('a * 'self) option
    method concat : 'a clist -> 'a clist
    method flatten : ('a, 'b list) eq -> 'b list
  end

let olist l =
  let rec flatten : type a b. (a, b list) eq -> a #clist -> b list =
   fun eq l ->
    match l#uncons with
    | None -> []
    | Some (pa, x) ->
      let a : b list =
        let Refl = eq in
        pa
      in
      a @ flatten eq x
  in
  object (self : 'a clist)
    val inner = l
    method length = List.length inner

    method uncons : ('a * 'a clist) option =
      match inner with
      | [] -> None
      | a :: q -> Some (a, {<inner = q>})

    method concat (_ : 'a clist) = assert false

    method flatten : 'b. ('a, 'b list) eq -> 'b list =
      fun eq -> flatten eq self
  end
;;

module O = struct
  class type ['a] obj_list =
    object ('self)
      method length : int
      method append : 'a list -> 'a obj_list
      method uncons : ('a * 'self) option
      method sum : ('a, int) eq -> int
      method flatten : ('a, 'b list) eq -> 'b list
    end

  let my_list (list : 'a list) =
    object (self : 'a #obj_list)
      val l = list
      method length = List.length l
      method append x = {<l = List.append l x>}

      method uncons =
        match l with
        | [] -> None
        | x :: xs -> Some (x, {<l = xs>})

      method sum =
        let aux : type a. a list -> (a, int) eq -> int =
         fun list Refl -> List.fold_left (fun acc x -> acc + x) 0 list
        in
        aux l

      method flatten : 'b. ('a, 'b list) eq -> 'b list =
        let rec aux : type a b. a #obj_list -> (a, b list) eq -> b list =
         fun list witness ->
          match list#uncons with
          | None -> []
          | Some (head_list, xs) ->
            let flatten_list : b list =
              let Refl = witness in
              head_list
            in
            flatten_list @ aux xs witness
        in
        aux self
    end
  ;;
end

module Injective (T : sig
  type 'a t
end) =
struct
  let make (type a b) (Refl : ('a T.t, 'b T.t) eq) : ('a, 'b) eq = Refl
end

module I = Injective (struct
  type 'a t = 'a list
end)

let b = O.my_list [ [ 1 ]; [ 2 ]; [ 3 ] ]
let c = b#flatten Refl
let _ = assert ([ 1; 2; 3 ] = c)
let d = (O.my_list c)#sum Refl
let _ = assert (6 = d)
let b = O.my_list [ "foo"; "bar" ]
let c = (O.my_list [ 1; 2; 3; 4 ])#flatten Refl
