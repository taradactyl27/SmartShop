const User = require("../models/User");
const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const keys = require("../config/keys");

async function createTask(id,task) {
  let returnVal = false;
  var myPromise = () => {
    return new Promise((resolve,reject) =>{
    User.findOneAndUpdate({"_id": id}, 
    {$push: {"scheduledtasks": task}}, 
    {new: true, safe: true, upsert:true}).then((result) => {
      return resolve(true);
    }).catch((error) => {
        return reject(false);
      });
    });
  };
  var callPromise = async () => {
    var result = await (myPromise());
    return result;
  };
  callPromise().then(result => {
    returnVal = result;
  });
  return returnVal;
};

async function makeactive(id,task){
  let returnVal = false;
  var myPromise = () => {
    return new Promise((resolve,reject) =>{
      User.findOneAndUpdate({"_id": id}, 
      {$pull: {"scheduledtasks": task}}, 
      {new: true, safe: true, upsert:true}).then((result) => {
    }).catch((error) => {
        reject(false);
    });
  
    User.findOneAndUpdate({"_id": id}, 
      {$push: {"activetasks": task}}, 
      {new: true, safe: true, upsert:true}).then((result) => {
        resolve(true);
    }).catch((error) => {
        reject(false);
      });
    });
  };
  var callPromise = async () => {
    var result = await (myPromise());
    return result;
  };
  callPromise().then(result => {
    returnVal = result;
  });
  return returnVal;
};

async function makescheduled(id,task){
  let returnVal = false;
  var myPromise = () => {
    return new Promise((resolve,reject) =>{
      User.findOneAndUpdate({"_id": id}, 
      {$pull: {"activetasks": task}}, 
      {new: true, safe: true, upsert:true}).then((result) => {
    }).catch((error) => {
        reject(false);
    });
  
    User.findOneAndUpdate({"_id": id}, 
      {$push: {"scheduledtasks": task}}, 
      {new: true, safe: true, upsert:true}).then((result) => {
        resolve(true);
    }).catch((error) => {
        reject(false);
      });
    });
  };
  var callPromise = async () => {
    var result = await (myPromise());
    return result;
  };
  callPromise().then(result => {
    returnVal = result;
  });
  return returnVal;
};

async function deletetask(id,task){
  console.log(id,task);
  let returnVal = false;
  var myPromise = () => {
    return new Promise((resolve,reject) =>{
      User.findOneAndUpdate({"_id": id}, 
        {$pull: {"scheduledtasks": task}}, 
        {new: true, safe: true, upsert:true}).then((result) => {
          console.log("deleted just fine"); 
          resolve(true);
      }).catch((error) => {
        console.log(error);
        reject(false);
      });
    });
  };
  var callPromise = async () => {
    var result = await (myPromise());
    return result;
  };
  callPromise().then(result => {
    returnVal = result;
  });
  return returnVal;
};

router.post("/createtask", async (req,res) =>{
  let task = req.body.data;
  let id = req.body.id;
  if (createTask(id,task)){
    return res.status(200).json({createTask: "Created task successfully!"});
  }
  else{
    return res.status(400).json({createTask: "Creating task failed!"});
  }
});

router.delete("/deletetask", (req,res) =>{
  let task = req.body.data;
  let id = req.body.id;
  if (deletetask(id,task)){
    return res.status(200).json({createTask: "Deleted task successfully!"});
  }
  else{
    return res.status(400).json({createTask: "Deleting task failed!"});
  }
  });

router.put("/makeactive", (req, res) => {
  let task = req.body.data;
  let id = req.body.id;
  if (makeactive(id,task)){
    return res.status(200).json({createTask: "Task made active successfully!"});
  }
  else{
    return res.status(400).json({createTask: "Making task active failed!"});
  }
});

router.put("/makescheduled", (req, res) => {
  let task = req.body.data;
  let id = req.body.id;
  if (makescheduled(id,task)){
    return res.status(200).json({createTask: "Task Scheduled successfully!"});
  }
  else{
    return res.status(400).json({createTask: "Task Scheduling failed!"});
  }
});




module.exports = router;
