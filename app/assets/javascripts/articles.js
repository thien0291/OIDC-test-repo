function setupOverlay() {
  const paywallOverlay = document.getElementById('paywall-overlay');
  const closeOverlayButton = document.getElementById('close-overlay');
  const body = document.body;

  function scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }

  function showOverlay() {
    paywallOverlay.setAttribute('aria-hidden', 'false');
    body.classList.toggle('noscroll', true);
    // Prevent ongoing scrolling behavior
    setTimeout(scrollToTop, 200);
  }

  function closeOverlay() {
    paywallOverlay.setAttribute('aria-hidden', 'true');
    body.classList.toggle('noscroll', false);
    window.removeEventListener('scroll', checkScrollPosition);
    console.log("overlay closed");
  }

  function checkScrollPosition() {
    // Get the current scroll position and viewport height
    const scrollPosition = window.scrollY;
    const viewportHeight = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0) / 1.5;

    if (scrollPosition >= viewportHeight) {
      showOverlay();
      window.removeEventListener('scroll', checkScrollPosition); // Remove the scroll listener after showing the overlay
    }
  }

  closeOverlayButton.addEventListener('click', () => {
    closeOverlay();
  });

  // Listen for the scroll event on the window
  window.addEventListener('scroll', checkScrollPosition);

  console.log("overlay init");

  // Handle navigation away from the page
  window.addEventListener('beforeunload', () => {
    closeOverlay();
    console.log("out");
  });
};

setupOverlay();