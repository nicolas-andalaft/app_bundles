extension RunNotNull on dynamic {
  dynamic runNotNull<T>(dynamic Function(T) function) {
    return this == null ? null : function(this);
  }
}
