document.addEventListener("DOMContentLoaded", () => {
  let navItems = Array.from(document.querySelectorAll('.sidebar-nav li'));
  window.location.hash = "#inbox";

  navItems.forEach(navItem => {
    navItem.addEventListener("click", () => {
      let name = navItem.innerText.toLowerCase();
      window.location.hash = name;
    });
  });
});
