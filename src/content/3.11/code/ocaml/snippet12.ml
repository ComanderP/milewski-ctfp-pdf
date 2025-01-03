module FreeFunctorAlt (F : sig
  type 'a t
end) : Functor = struct
  module type F = FreeF_Alt with type 'a f = 'a F.t

  type 'a t = (module F with type a = 'a)

  let fmap (type a' b') f (module FF : F with type a = a') =
    (module struct
      type a = b'
      type 'a f = 'a F.t

      let freeF bi = FF.freeF (fun a -> bi (f a))
    end : F
      with type a = b')
end
