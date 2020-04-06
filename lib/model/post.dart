class Post {
  const Post({
  this.title,
  this.imgUrl
  });
  final String title;
  final String imgUrl; 
}

final List<Post> posts = [
  Post(
    title: '美式音标入门课',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/37/117/20191030171614981430000713.jpeg',
  ),
  Post(
    title: '甩掉字幕看美剧',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/53/427/20190729170902212357000706.jpg',
  ),
  Post(
    title: '时态语法14讲',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/239/240/20190729171109284839000313.jpg',
  ),
  Post(
    title: '懂点英文演讲',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/166/392/20190729181922822355000647.jpg',
  ),
  Post(
    title: '实用情景英语',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/87/43/20190729182233366854000708.jpg',
  )
];