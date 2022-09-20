let generate_qrcode filename uri =
  uri
  |> Qrc.encode
  |> Option.map Qrc.Matrix.to_svg
  |> Option.fold
       ~none:(fun () -> print_endline "unable to generate QRCode")
       ~some:(fun content () ->
         let channel = open_out filename in
         let () = output_string channel content in
         let () = close_out channel in
         Format.printf "Done for [%s] in %s\n" uri filename)
;;

let () =
  generate_qrcode
    "images/capsule.svg"
    "https://xvw.github.io/capsule/pages/oop-refl.html"
    ();
  generate_qrcode
    "images/oop-sym.svg"
    "https://www.youtube.com/watch?v=TrameN7BTCQ"
    ()
;;
