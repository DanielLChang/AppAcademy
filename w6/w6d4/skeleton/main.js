const Router = require('./router');
const Inbox = require('./inbox');
const Sent = require('./sent');
const Compose = require('./compose');

let routes = {
  inbox: Inbox,
  sent: Sent,
  compose: Compose
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
