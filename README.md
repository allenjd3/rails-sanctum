# README

This is a sample application that demonstrates how to use breeze-nextjs with rails.

This is for fun only- use at your own risk!

Steps covered in this lesson:
1. Install rails- with bcrypt, factory_bot_rails and faker (and rack-cors)
2. Install breeze next
3. Add and seed users
4. Disable csrf protection-
    1. Create cookie decrypt function on application_controller
    2. Make sure you use secure comparison to prevent timing attacks
5. Create csrf endpoint- sanctum/csrf-cookie
6. Create login endpoint
7. Create api/user endpoint- create before_action authenticate user
8. Create logout endpoint
9. Test it live

Video tutorial- https://youtu.be/_o6mzaSvDpg
