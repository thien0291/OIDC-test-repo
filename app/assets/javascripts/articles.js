function setupOverlay() {
  const paywallOverlay = document.getElementById('paywall-overlay');
  const body = document.body;

  // better solution to solve scrolling stops when mouse moves
  function scrollToTop() {
    const duration = 0;
    const startPosition = window.scrollY;
    const startTime = performance.now();
  
    function animateScroll(timestamp) {
      const timeElapsed = timestamp - startTime;
      window.scrollTo({
        top: easeInOutQuad(timeElapsed, startPosition, -startPosition, duration),
        behavior: 'smooth'
      });
      if (timeElapsed < duration) requestAnimationFrame(animateScroll);
    }
  
    requestAnimationFrame(animateScroll);
  }
  
  function easeInOutQuad(t, b, c, d) {
    t /= d / 2;
    if (t < 1) return (c / 2) * t * t + b;
    t--;
    return (-c / 2) * (t * (t - 2) - 1) + b;
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

  if (paywallOverlay) {
    // Listen for the scroll event on the window
    window.addEventListener('scroll', checkScrollPosition);

    console.log("overlay init");

    // Handle navigation away from the page
    window.addEventListener('beforeunload', () => {
      closeOverlay();
      console.log("out");
    });
  } else {
    console.log("have access to article")
  }
};

setupOverlay();