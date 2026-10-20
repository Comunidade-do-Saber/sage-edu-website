/*  navbarItens: all navbar children
    hamburgerMenuToggleBtn: open/close navbar icon */
const navbarItens = document.querySelector(".nav-links");
const languageSwitcher = document.getElementById('languageSwitcher');
const hamburgerMenuToggleBtn = document.querySelector(".hamburger");

hamburgerMenuToggleBtn.addEventListener("click", toggleMobileNavbar);
navbarItens.addEventListener("click", closeMobileNavbar);

/* keeps navbar from closing when the language switcher is tapped */
languageSwitcher.addEventListener("click", e => e.stopPropagation());

function toggleMobileNavbar() {
    navbarItens.classList.toggle("nav-links--open");
    hamburgerMenuToggleBtn.classList.toggle("hamburger--open");
}

function closeMobileNavbar() {
    navbarItens.classList.remove("nav-links--open");
    hamburgerMenuToggleBtn.classList.remove("hamburger--open");
}


