function Anime(title, year, director){
  this.title = title;
  this.year = year;
  this.director = director;

  Anime.prototype.toString = function () {
    return this.title + " was released in " + this.year + " and directed by " + this.director + ".";
  };
}

var anime1 = new Anime( "Ghost in the Shell", 1995, "Mamoru Oshii")
var anime2 = new Anime( "FullMetalAlchemist", 2011, "Kazuya Murata")

console.log( anime1.toString() );
console.log( anime2.toString() );
