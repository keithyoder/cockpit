// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// Dynamic Time Function

function updateTime() {
  let currentTime = new Date();
  let hours = currentTime.getHours();
  let minutes = currentTime.getMinutes();

  hours = (hours < 10 ? "0" : "") + hours;
  minutes = (minutes < 10 ? "0" : "") + minutes;

  let timeString = hours + " : " + minutes;
  document.querySelector(".time").innerHTML = timeString;
  

  $.getJSON('http://localhost:3000/dashboard.json', function (data) {
    document.querySelector("#velocity").innerHTML = data.velocity;
    document.querySelector("#outdoor_temperature").innerHTML = `${data.outdoor_temperature}° C`;
    document.querySelector("#battery_voltage").innerHTML = `${data.battery_voltage}V`;
    document.querySelector("#battery_percentage").innerHTML = `${battery_percentage(data.battery_voltage)}%`;
    document.querySelector("#fuel-remaining").innerHTML = `${data.fuel_remaining} L`;
    document.querySelector("#fuel_percentage").innerHTML = `${fuel_percentage(data.fuel_remaining)}%`;
    document.querySelector(".speedometer-pointer").style.transform = "rotate("+velocity_rotate(data.velocity).toString()+"deg)"
  })
}
  
updateTime();
setInterval(updateTime, 1000);
  
// Dynamic Date Function

function velocity_rotate(velocity) {
  return velocity * 3/2 + 30
}

function updateDate() {
  let currentDate = new Date();
  let day = currentDate.getDate();
  let month = currentDate.getMonth() + 1;
  let year = currentDate.getFullYear();

  month = (month < 10 ? "0" : "") + month;

  let dateString = day + " / " + month + " / " + year;
  document.querySelector(".date").innerHTML = dateString;
}

updateDate();

setInterval(updateDate, 1000);

function battery_percentage(voltage) {
  const FULL_BATTERY = 12.88;
  const EMPTY_BATTERY = 11.80;
  let range = FULL_BATTERY - EMPTY_BATTERY;
  let percentage = 100 - ((FULL_BATTERY - voltage) / range) * 100;

  if (percentage < 0) {
    return 0
  }  else {
    return Math.trunc(percentage);
  }    
}

function fuel_percentage(fuel_remaining) {
  const TANK_SIZE = 40;
  let percentage = (fuel_remaining / TANK_SIZE) * 100;

  if (percentage < 0) {
    return 0
  }  else {
    return Math.trunc(percentage);
  }
}