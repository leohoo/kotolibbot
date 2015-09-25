var casper = require("casper").create();

casper.start("https://www.koto-lib.tokyo.jp/opw/OPW/OPWUSER.CSP");
casper.thenEvaluate(function() {
    document.querySelector("input[name=usercardno]").value = "005731906";
    document.querySelector("input[name=userpasswd]").value = "xxxx";
});


casper.then(function(){
    this.click("input[type=submit]");
    this.captureSelector("button.png", "input[type=submit]");
    this.wait(10000, function(){
        this.capture("screenshot.png");    
    });
});

casper.run();
