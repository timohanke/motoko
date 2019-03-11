/*
 * Association Lists, a la functional programming, in ActorScript.
 */


// polymorphic association linked lists between keys and values
type AssocList<K,V> = List<(K,V)>;

let AssocList = new {

  // find the value associated with a given key, or null if absent.
  func find<K,V>(al : AssocList<K,V>, k:K, k_eq:(K,K)->Bool)
       : ?V {
    func rec(al:AssocList<K,V>) : ?V {
      switch (al) {
      case (null) null;
      case (?((hd_k, hd_v), tl)) {
             if (k_eq(k, hd_k)) {
               ?hd_v
             } else {
               rec(tl)
             }
           };
    }};
    rec(al)
  };

  // replace the value associated with a given key, or add it, if missing.
  // returns old value, or null, if no prior value existed.
  func replace<K,V>(al : AssocList<K,V>, k:K, k_eq:(K,K)->Bool, ov:?V)
       : (AssocList<K,V>, ?V) {
    func rec(al:AssocList<K,V>) : (AssocList<K,V>, ?V) {
      switch (al) {
      case (null) {
             switch ov {
               case (null) (null, null);
               case (?v) (?((k, v), null), null);
             }
           };
      case (?((hd_k, hd_v), tl)) {
             if (k_eq(k, hd_k)) {
               // if value is null, remove the key; otherwise, replace key's old value
               // return old value
               switch ov {
                 case (null) (tl, ?hd_v);
                 case (?v)   (?((hd_k, v), tl), ?hd_v);
               }
             } else {
               let (tl2, old_v) = rec(tl);
               (?((hd_k, hd_v), tl2), old_v)
             }
           };
    }};
    rec(al)
  };

  // The key-value pairs of the final list consists of those pairs of
  // the left list whose keys are not present in the right list; the
  // values of the right list are irrelevant.
  func diff<K,V,W>(al1 : AssocList<K,V>, al2:AssocList<K,W>) : AssocList<K,V> {
    /// xxx
    null
  };

  // This operation generalizes the notion of "set union" to finite maps.
  // Produces a "disjunctive image" of the two lists, where the values of
  // matching keys are combined with the given binary operator.
  //
  // For unmatched key-value pairs, the operator is still applied to
  // create the value in the image.  To accomodate these various
  // situations, the operator accepts optional values, but is never
  // applied to (null, null).
  //
  func disj<K,V,W,X>(al1 : AssocList<K,V>, al2:AssocList<K,W>,
                     keq:(K,K)->Bool, vbin:(?V,?W)->X) : AssocList<K,X> {
    /// xxx
    null
  };

  // This operation generalizes the notion of "set intersection" to
  // finite maps.  Produces a "conjuctive image" of the two lists, where
  // the values of matching keys are combined with the given binary
  // operator, and unmatched key-value pairs are not present in the output.
  //
  func conj<K,V,W,X>(al1 : AssocList<K,V>, al2:AssocList<K,W>,
                     keq:(K,K)->Bool, vbin:(V,W)->X) : AssocList<K,X> {
    /// xxx
    null
  };


  func fold<K,V,X>(al:AssocList<K,V>, nil:X, cons:(K,V,X)->X) : X {
    func rec(al:List<(K,V)>) : X = {
      switch al {
      case null nil;
      case (?((k,v),t)) { cons(k, v, rec(t)) };
      }
    };
    rec(al)
  };

};
