# testAPI

This is built for an internship task

1. POST /user/create
   For creating new user
   request formdata(url-encoded):
   body: {
     name: optional,
     email: required,
     password: required
   }

2. POST /user/login
   For logging in 
   body: {
     email: required,
     password: required
   }
   response: a JWT token for further logins

   
4. POST /image/like|superlike
   For like or superlike an image
   info should be in JWT token in authorization header
   userId: who likes
   imageId: id of image

5. POST /user/block
   for blocking a user by another user
   info should be in JWT token in authorization header
   blocker: user id who requests to block
   blocked: user id who is to block
   
For routes 4 and 5 to the api you must pass an authorization token in authorization header.
Give that string in .env file's environment variable (JWT_KEY)  
