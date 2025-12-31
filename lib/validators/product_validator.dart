class ProductValidator {
  static productName (v){
    if(v == null || v.trim().isEmpty){
      return 'Name is required';
    }
  }

  static productPrice(v){
    final val = double.tryParse(v ?? '');
    if (val == null || val < 0) return 'Price must be grater than 0';
    return null;
  }

  static productStock(v){
    final val = int.tryParse(v ?? '');
    if (val == null || val < 0) return 'Stock must be greater than 0';
    return null;
  }
}