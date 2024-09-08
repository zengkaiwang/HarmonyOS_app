export class BannerClass {
  id: string = '';
  imageSrc: string = '';
  url: string = '';

  constructor(id: string, imageSrc: string, url:string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.url = url;
  }
}