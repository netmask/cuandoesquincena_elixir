"use strict";

function secondsFromUTC(){
    return (new Date().getTimezoneOffset() * 60);
};

function Quincena(element){
    this.request = new XMLHttpRequest();
    this.payload = null;
    this.message = null;
    this.seconds_until = null;
    this.element = element;

    this.request.onreadystatechange = this.onPayload.bind(this);
};

Quincena.prototype.onPayload = function(event) {
    if (event.target.readyState == 4 && event.target.status == 200) {
        var response = JSON.parse(event.target.responseText);

        this.payload = response.seconds_until_payday;
        this.message = response.silly_message;
        this.seconds_until = this.payload +  secondsFromUTC();
    }
};

Quincena.prototype.getPayload = function(){
    this.request.open('GET', 'api', true);
    this.request.send();
};

Quincena.prototype.start = function(){
    this.getPayload();
    setInterval(this.tick.bind(this), 1000);
};

Quincena.prototype.tick = function(){
    this.seconds_until -= 1;
    this.render();
};

Quincena.prototype.calculate = function(){
    var wdays = (this.seconds_until % 86400);
    var wminutes = ( wdays % 3600);

    var days = Math.floor(this.seconds_until / 86400);
    var hours = Math.floor( wdays / 3600);
    var minutes = Math.floor(wminutes / 60);
    var seconds = wminutes % 60;

    return [days, hours, minutes, seconds];
};

Quincena.prototype.render = function(){

    var templateContent = this.element.querySelector('.counter-body');
    var values = this.calculate();

    ['.days', '.hours', '.minutes', '.seconds'].forEach((v, i) =>{
      templateContent.querySelector(v).textContent = values[i];
    });
};

document.addEventListener("DOMContentLoaded", function(event) {
    window.quincena = new Quincena(document.querySelector(".counter"));
    window.quincena.start();
});
