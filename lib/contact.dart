class Contact {
  final int id;
  final String name;
  final String phone;
  final String email;

  Contact(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email});

  @override
  String toString() {
    return "$id,$name,$phone,$email";
  }
}
