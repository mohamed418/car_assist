class CurrentUserModel {
  late final String name;
  late final String email;
  late final String mobile;
  late final String id;
  late final bool status;

  CurrentUserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    id = json['id'];
    status = json['status'];
  }

}