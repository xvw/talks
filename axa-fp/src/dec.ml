let defaultValue default opt = 
  match opt with
  | Some x -> x
  | None -> default
