import Prim "mo:prim";
actor a {
  // test that oneways can locally try/throw
  public func oneway() : () {
    ignore (
      async {
        Prim.debugPrint "1";
        try {
          throw (error("Error"));
          Prim.debugPrint "unreachable";
        }
        catch e { Prim.debugPrint "2"};
      }
    )
  };

  // test that oneways can locally try/throw
  // using `=` syntax
  public func onewayAlt() : () =
    ignore (
      async {
        Prim.debugPrint "3";
        try {
          throw (error("Error"));
          Prim.debugPrint "unreachable";
        }
        catch e { Prim.debugPrint "4"};
      }
    );


  // test that throws from oneways are silently discarded (because replies are eager)
  public func discard() : () {
    ignore (
      async {
        Prim.debugPrint "5";
        throw (error("ignored"));
        Prim.debugPrint "unreachable";
      }
    )
  };

  // test that throws from oneways are silently discarded (because replies are eager)
  // using `=` syntax
  public func discardAlt() : () =
    ignore (
      async {
        Prim.debugPrint "6";
        throw (error("ignored"));
        Prim.debugPrint "unreachable";
      }
    );

  // TODO test await and calls to shared functions

  public func go() = ignore async {
    Prim.debugPrint("A");
    oneway();
    Prim.debugPrint("B");
    onewayAlt();
    Prim.debugPrint("C");
    discard();
    Prim.debugPrint("D");
    discardAlt();
    Prim.debugPrint("E");
  };
};
a.go(); //OR-CALL ingress go 0x4449444C0000
