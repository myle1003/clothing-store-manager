var schedule = require('node-schedule');
// const moment = require('moment');

const date = new Date();
console.log(date)
date.setMinutes(date.getMinutes() + 1);
console.log(date);
var scheduleUpdate = schedule.scheduleJob(date, function(){
    console.log('1');
});
