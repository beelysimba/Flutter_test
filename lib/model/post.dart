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
    title: '美式音标零基础入门课',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/163/470/20191030171610429574000835.jpeg',
  ),
  Post(
    title: '21天甩掉字幕看美剧',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/218/97/20190729181722976419000144.jpg',
  ),
  Post(
    title: '时态语法14讲',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/59/463/20190729171116916886000634.jpg',
  ),
  Post(
    title: '懂点英文演讲',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/88/349/20190729181928637565000243.jpg',
  ),
  Post(
    title: '实用情景英语',
    imgUrl: 'http://qn-cdn-img.mofunenglish.com/44/263/20190729182240094202000449.jpg',
  )
];