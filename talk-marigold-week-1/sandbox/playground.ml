type time = int

type _ state =
  | Running : time -> [ `Running ] state
  | Paused : time -> [ `Paused ] state

let start () = Running 0
let resume (Paused x) = Running x
let pause (Running x) = Paused x
let tick (Running x) = Running (x + 1)
let sleep time (Paused x) = Paused (time + x)
let a = start () |> tick |> pause |> resume |> tick
let b = start () |> tick |> pause |> sleep 10 |> resume |> tick
let c = start () |> sleep 10
