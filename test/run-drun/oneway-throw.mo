import Prim "mo:prim";
actor a {
  var committed = false;
  public func throws() : () = ignore async {
    Prim.debugPrint "throws()";
    committed := true;
    throw (error("ignored"));
    Prim.debugPrint "unreachable";
  };
  public func ping() : async () {
    Prim.debugPrint "ping()";
  };
  public func go() = ignore async {
    Prim.debugPrint "go1";
    throws();
    await ping(); // in-order delivery guarantees that throw ran
    Prim.debugPrint "go2";
    assert(committed);
  };
};
a.go(); //OR-CALL ingress go "DIDL\x00\x00"
