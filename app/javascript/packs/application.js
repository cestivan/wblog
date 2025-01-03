import 'styles/application'
import '../js/base'
import '../js/about'

document.addEventListener('DOMContentLoaded', () => {
  const notificationBar = document.getElementById('notification-bar');
  const closeBtn = notificationBar?.querySelector('.close-btn');
  const message = notificationBar?.querySelector('.message')?.textContent;

  if (notificationBar && message && !localStorage.getItem('notificationClosed')) {
    notificationBar.classList.remove('d-none');
  }

  closeBtn?.addEventListener('click', () => {
    notificationBar.classList.add('d-none');
    localStorage.setItem('notificationClosed', 'true');
  });
});