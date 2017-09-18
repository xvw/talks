module Parser :
sig

  type token =
    | Left
    | Right
    | Plus
    | Minus
    | Input
    | Output
    | Loop of token list

  val of_string : string -> token list

end = struct

  type token =
    | Left
    | Right
    | Plus
    | Minus
    | Input
    | Output
    | Loop of token list


  let string_of_list str =
    let len = String.length str in
    let rec aux acc i =
      if i = -1 then acc 
      else aux (str.[i] :: acc) (i - 1)
    in aux [] (len - 1)

  let of_string str =
    let rec aux acc li =
      match li with
      | [] -> ([], List.rev acc)
      | '<' :: xs -> aux (Left :: acc) xs
      | '>' :: xs -> aux (Right :: acc) xs
      | '-' :: xs -> aux (Minus :: acc) xs
      | '+' :: xs -> aux (Plus :: acc) xs
      | '.' :: xs -> aux (Output :: acc) xs
      | ',' :: xs -> aux (Input :: acc) xs
      | ']' :: xs -> (xs, List.rev acc)
      | '[' :: xs ->
         let (rest, loop) = aux [] xs in
         aux ((Loop loop) :: acc) rest
      | _ :: xs -> aux acc xs
    in snd (aux [] (string_of_list str))

end

module Zipper :
sig

  type 'a zipper
  val create : 'a -> 'a zipper
  val move_left : 'a zipper -> 'a zipper
  val move_right: 'a zipper -> 'a zipper
  val current : 'a zipper -> 'a
  val change : 'a zipper -> 'a -> 'a zipper

end = struct

  type 'a zipper = {
      left : 'a list
    ; right : 'a list
    ; default: 'a
    }

  let create default = {
      left = []
    ; right = []
    ; default = default
    }

  let move_left zipper =
    match zipper.left with
    | [] -> {
        zipper with
        left = []
      ; right = zipper.default :: zipper.right
      }
    | x :: xs -> {
        zipper with
        left = xs
      ; right = x :: zipper.right
      }

  let move_right zipper =
    match zipper.right with
    | [] -> {
        zipper with
        right = []
      ; left = zipper.default :: zipper.left
      }
    | x :: xs -> {
        zipper with
        right = xs
      ; left = x :: zipper.left
      }


  let current zipper =
    match zipper.left with
    | [] -> zipper.default
    | x :: _ -> x

  let change zipper value =
    { zipper with left = value :: zipper.left}
               

end



let run str  =
  let tokens = Parser.of_string str in
  let zipper = Zipper.create 0 in
  let rec aux zipper brainfuck =
    print_int (Zipper.current zipper);
    match brainfuck with
    | [] -> ()
    | Parser.Plus :: xs ->
       let value = Zipper.current zipper in
       aux (Zipper.change zipper (value + 1)) xs
    | Parser.Minus :: xs ->
       let value = Zipper.current zipper in
       aux (Zipper.change zipper (value - 1)) xs
    | Parser.Left :: xs ->
       aux (Zipper.move_left zipper) xs
    | Parser.Right :: xs ->
       aux (Zipper.move_right zipper) xs
    | Parser.Output :: xs ->
       let () =
         Zipper.current zipper
         |> char_of_int
         |> print_char
       in aux zipper xs
    | Parser.Input :: xs ->
       aux zipper xs
    | (Parser.Loop loop) :: xs ->
       if (Zipper.current zipper) = 0 then aux zipper xs
       else aux zipper loop; aux zipper brainfuck
  in aux zipper tokens
