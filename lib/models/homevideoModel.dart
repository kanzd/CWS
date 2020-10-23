class HomeVideoModel {
  var thumbnail;
  var video;
  var likes;
  var comments;
  var dislikes;
  var commentsL;
  var title;
  var key;
 
  var time;
  var length;
  var docid;
  var hashtag;
  var views;
  var follows;
  var type;
  HomeVideoModel(
      {var thumbnail,
      var video,
      var hashtag,
      var follows,
      var type,
      var docid,
      var likes,
      var comments,
      var key,
      
      var time,
      var dislikes,
      var commentsL,
      var length,
      var title,
      var views}) {
    this.thumbnail = thumbnail;
    this.video = video;
    this.title = title;
    this.likes = likes;
    this.comments = comments;
    this.dislikes = dislikes;
    this.key = key;
    this.type = type;
    this.commentsL = commentsL;
    this.follows = follows;
    this.length = length;
    this.type = type;
    this.hashtag = hashtag;
    this.docid = docid;
    this.time = time;
    this.views = views;
  }
}
