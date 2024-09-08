export class ArticleClass {
  id: string = '';
  imageSrc: string = '';
  title: string = '';
  brief: string = '';
  webUrl: string = '';

  constructor(id: string, imageSrc: string, title: string, brief: string, webUrl: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.title = title;
    this.brief = brief;
    this.webUrl = webUrl;
  }
}