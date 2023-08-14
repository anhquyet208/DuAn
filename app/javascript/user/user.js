$(document).ready(function() {
// Arrays of strings for the date display
const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const months = [
  'Jan', 'Feb', 'Mar', 'Apr',
  'May', 'Jun', 'Jul', 'Aug',
  'Sep', 'Oct', 'Nov', 'Dec'
];

// Get the DOM elements
const dateDisplay = document.getElementById('date');
const hourHand = document.getElementById('hour-hand');
const minuteHand = document.getElementById('minute-hand');
const secondHand = document.getElementById('second-hand');
const digitalTime = document.getElementById('digital-time');

let darkMode = localStorage.getItem('darkmode');
// console.log(darkMode);
if (darkMode == 'yes') {
  document.body.classList.add('dark');
  document.getElementById('dark-mode-toggle').checked = 'true';
}

// Dark mode toggle
document.getElementById('dark-mode-toggle').addEventListener('change', function(){
  document.body.classList.toggle('dark');
  if (darkMode == 'no') {
    darkMode = 'yes';
  } else {
    darkMode = 'no';
  }
  localStorage.setItem('darkmode', darkMode);
});

// Initialise second hand
let timeNow = new Date();
let seconds = timeNow.getSeconds();
let sRot = seconds * 6 - 96;

// Get and display the time
const clock = function() {

  let timeNow = new Date();
  // DEBUG: new Date(year, month, day, hours, minutes, seconds)
  // timeNow = new Date(2019,7,21,18,22,41);
  // DEBUG end

  // Display the date
  let day = timeNow.getDay();
  let date = timeNow.getDate();
  let month = timeNow.getMonth();
  dateDisplay.innerHTML = `${days[day]}, ${format(date)} ${months[month]}`;

  // Each second is 6 degrees of arc.
  // Second hand moves in discrete steps
  let seconds = timeNow.getSeconds();
  // let sRot = seconds * 6 - 90;
  sRot = sRot + 6;

  // Each minute is 6 degrees of arc.
  // Add seconds/10 for smooth movement of minute hand
  let minutes = timeNow.getMinutes();
  let mRot = (minutes * 6) + (seconds / 10) - 90;

  // Each hour is 30 degrees of arc.
  // Add minutes/2 for smooth movement of hour hand
  let hours = timeNow.getHours();
  let hRot = (hours % 12 * 30) + (minutes / 2) - 90;

  // Position the hands
  hourHand.style.transform = `rotate(${hRot}deg)`;
  minuteHand.style.transform = `rotate(${mRot}deg)`;
  secondHand.style.transform = `rotate(${sRot}deg)`;

  // Display the digital clock
  digitalTime.innerHTML = `${format(hours)}:${format(minutes)}:${format(seconds)}`;

}

// Helper function to add leading zero
function format(num) {
  return num < 10 ? `0${num}` : num;
}

// IIFE to run the clock
(function run() {
  clock();
  setTimeout(function() { run(); }, 1000);
})();

})

document.addEventListener('DOMContentLoaded', function() {
  var button = document.getElementById('checkin_out_button');
  button.addEventListener('click', function() {
    if (button.innerText === 'Check In') {
      button.innerText = 'Check Out';
    }
    else {
      button.innerText = 'Check In';
    }
  });
});
