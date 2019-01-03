import Typed from 'typed.js';

function loadDynamicBannerText() {
    new Typed('#banner-typed-text', {
        strings: ["Want to know job market in China?","Enter a job keyword.", "You can get salary, location, skills analysis."],
        typeSpeed: 40,
        loop: true
    });
};

export { loadDynamicBannerText };