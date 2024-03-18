import '../services/accounts_db.dart';

class Account {
  String? uid;
  String? fullName;
  String? reg;
  String? id;
  String? type;
  String? fName;
  String? mName;
  String? dob;
  String? phone;
  String? pass;
  String? email;
  String? post;
  String? degree;
  String? dept;
  String? join;
  String? semester;

  Account({
    this.uid,
    this.reg,
    this.id,
    this.dob,
    this.fName,
    this.fullName,
    this.mName,
    this.pass,
    this.phone,
    this.type,
    this.email,
    this.post,
    this.degree,
    this.dept,
    this.join,
    this.semester,
  });
}

List accountList = [];

// getting the list
Future<bool> getListAccount() async {
  accountList = [];

  List? jsonList = await AccountsDB().createAccountDataList();
  for (var element in jsonList!) {
    var data = element.data();
    accountList.add(Account(
      uid: data["uid"],
      reg: data["reg"],
      id: data["id"],
      dob: data["dob"],
      fName: data["fName"],
      fullName: data["fullName"],
      mName: data["mName"],
      pass: data["pass"],
      phone: data["phone"],
      type: data["type"],
      email: data["email"],
      post: data["post"],
      degree: data["degree"],
      dept: data["dept"],
      join: data["join"],
      semester: data["semester"],
    ));
  }

  print("\t\t\t\tGot Account list");
  return true;
}

// returns whether the account exists
bool accountExists(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid,
      orElse: () => null);
  return data != null ? true : false;
}

// returns the account of the user
Account? getAccount(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid,
      orElse: () => null);
  return data;
}
