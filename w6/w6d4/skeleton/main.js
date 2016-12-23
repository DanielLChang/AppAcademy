const Router = require('./router');
const Inbox = require('./inbox');

let routes = {
  inbox: Inbox
};

document.addEventListener("DOMContentLoaded", () => {
  let content = document.querySelector('.content');
  let router = new Router(content, routes);
  router.start();

  let navItems = Array.from(document.querySelectorAll('.sidebar-nav li'));
  window.location.hash = "#inbox";

  navItems.forEach(navItem => {
    navItem.addEventListener("click", () => {
      let name = navItem.innerText.toLowerCase();
      window.location.hash = name;
    });
  });
});
