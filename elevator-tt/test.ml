type time = int

type _ state =
  | Running : time -> [`Running] state
  | Paused : time -> [`Paused] state

let start () = Running 0

let tick (Running x) = Running (x + 1)

let pause (Running x) = Paused x

let sleep time (Paused x) = Paused (time + x)

let resume (Paused x) = Running x
