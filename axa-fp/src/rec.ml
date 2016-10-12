type 'a list =
  | Nil
  | Cons of ('a * 'a list)

[1;2]=Cons(1,Cons (2,Nil))
