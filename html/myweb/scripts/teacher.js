  var targetUrl= "students.kennesaw.edu/~dstrube";
  function login() {
     if (validLogin()) {
        password = document.userInfos.password.value;
        username = document.userInfos.username.value;
        //self.location.href=
        location =   "http://"+targetUrl+"/"+username+"/"+password+".html";
        }
     }
  function validLogin() {
     if (isBlank(document.userInfos.username.value)){
        alert("Can't be blank");
        document.userInfos.username.focus();
        return false;
        }
     if (isBlank(document.userInfos.password.value)){
        alert("Can't be blank");
        document.userInfos.password.focus();
        return false;
        }
     return true;      
     }
  function isBlank(s) {
     return (s == "");
     }
