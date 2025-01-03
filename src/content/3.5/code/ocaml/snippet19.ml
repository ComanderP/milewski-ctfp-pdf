module State_Monad (S : sig
  type t
end) : Monad_Bind with type 'a t = (S.t, 'a) state = struct
  type 'a t = (S.t, 'a) state

  let ( >>= ) sa k =
    State
      (fun s ->
        let a, s' = run_state sa s in
        let sb = k a in
        run_state sb s')

  let return a = State (fun s -> (a, s))
end
