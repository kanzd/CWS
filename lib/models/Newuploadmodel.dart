class NewuploadModel {
  var thumbnail;
  var video;
  var likes;
  var dislikes;
  var time;
  var comments;
  var hashtag;
  var name;
  var key;
  var follows;
  var length;
  var type;
  var views;
  var title;
  var docid;
  Map commentlist;
  NewuploadModel({
    var thumbnail,
    var video,
    var docid,
    var type,
    var likes,
    var title,
    var dislikes,
    var follows,
    var name,
    var hashtag,
    var length,
    var key,
    var time,
    var views,
    var comments,
    Map commentlist,
  }) {
    this.thumbnail = thumbnail;
    this.video = video;
    this.likes = likes;
    this.dislikes = dislikes;
    this.comments = comments;
    this.follows = follows;
    this.commentlist = commentlist;
    this.time = time;
    this.name = name;
    this.key = key;
    this.title = title;
    this.hashtag = hashtag;
    this.type = type;
    this.views = views;
    this.docid = docid;
    this.length = length;
  }
}
