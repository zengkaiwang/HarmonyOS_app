export class BannerClass {
  id: string = '';
  imageSrc: ResourceStr = '';
  url: string = '';

  constructor(id: string, imageSrc: ResourceStr, url:string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.url = url;
  }
}