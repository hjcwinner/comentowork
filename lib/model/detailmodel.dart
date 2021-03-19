class DetailModel {
  int id;
  String title;
  String contents;
  int categoryid;
  int userid;
  String createdat;
  String updatedat;
  String reply;

  DetailModel(
      {this.title,
      this.contents,
      this.categoryid,
      this.userid,
      this.id,
      this.createdat,
      this.updatedat,
      this.reply});
}
