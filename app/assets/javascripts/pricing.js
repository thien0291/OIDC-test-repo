const tabs = document.querySelectorAll('[data-tab-target]');
const tabContents = document.querySelectorAll('[data-tab-content] > div');

tabs.forEach((tab) => {
  tab.addEventListener('click', () => {
    tabs.forEach((t) => t.removeAttribute('active'));
    tab.setAttribute('active', '');
    
    tabContents.forEach((content) => {
      content.classList.remove('block', 'opacity-100');
      content.classList.add('hidden', 'opacity-0');
    });

    const target = tab.getAttribute('data-tab-target');
    const activeContent = document.querySelector(target);
    activeContent.classList.remove('hidden', 'opacity-0');
    activeContent.classList.add('block', 'opacity-100');
  });
});
