function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return `${this.owner} loves ${this.name}`;
};

let cat1 = new Cat("cat1", "owner1");
let cat2 = new Cat("cat2", "owner2");
let cat3 = new Cat("cat3", "owner3");

// console.log(cat1.cuteStatement());
// console.log(cat2.cuteStatement());
// console.log(cat3.cuteStatement());

Cat.prototype.cuteStatement = function () {
  return `Everyone loves ${this.name}`;
};

// console.log(cat1.cuteStatement());
// console.log(cat2.cuteStatement());
// console.log(cat3.cuteStatement());

Cat.prototype.meow = function() {
  return "meow";
};

// console.log(cat1.meow());
// console.log(cat2.meow());
// console.log(cat3.meow());

cat1.meow = function() {
  return "purr";
};

// console.log(cat1.meow());
// console.log(cat2.meow());
// console.log(cat3.meow());
