import Prim "mo:prim";
Prim.debugPrint (debug_show true);
let _ = actor {
  Prim.debugPrint (debug_show false);
  Prim.debugPrint (debug_show 1);
};
()
