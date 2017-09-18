type 'a zipper = {
    left:  'a list
  ; right: 'a list
  ; default: 'a
  }

let make default = {
    default = default
  ; left  = []
  ; right = []
  }

let insert zipper value = {
    zipper with
    left = value :: zipper.left
  }

let move_right zipper =
  match zipper.right with
  | [] -> {
      zipper with
      left = zipper.default :: zipper.left
    ; right = []
    }
  | x :: xs -> {
      zipper with
      left = x :: zipper.left
    ; right = xs
    }

let move_left zipper =
  match zipper.left with
  | [] ->  {
      zipper with
      left = []
    ; right = zipper.default :: zipper.right
    }
  | x :: xs -> {
      zipper with
      left = xs
    ; right = x :: zipper.right
    }
