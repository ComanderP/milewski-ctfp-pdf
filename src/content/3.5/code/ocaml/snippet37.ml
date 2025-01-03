(* Monad implementation for type io *)
module IOMonad : Monad_Bind with type 'a t = 'a io = struct
  type 'a t = 'a io

  let return x = IO (fun () -> x)

  let ( >>= ) m f =
    IO
      (fun () ->
        let (IO m') = m in
        let (IO m'') = f (m' ()) in
        m'' ())
end

(* main *)
module IO_Main = struct
  let ( let* ) = IOMonad.( >>= )

  let main =
    let* () = put_str "Hello" in
    put_str "world!"
end
