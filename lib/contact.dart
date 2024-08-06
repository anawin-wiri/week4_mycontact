class Contact {
  int id;
  String name;
  String phone;
  String email;

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
