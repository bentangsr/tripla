
# Getting Started

### API users
1. GET    /api/v1/users <sub>*list of users*</sub>
2. POST   /api/v1/users <sub>*create user*</sub>
3. GET    /api/v1/users/:id <sub>*detail user*</sub>

### API friendships
1. POST   /api/v1/friendship/follow <sub>*send follow request*</sub>
2. POST   /api/v1/friendship/accept_follow <sub>*accept follower*</sub>
3. POST   /api/v1/friendship/decline_follow <sub>*send decline following*</sub>
4. POST   /api/v1/friendship/unfollow <sub>*unfollow user*</sub>
5. POST   /api/v1/friendship/remove_follow <sub>*send remove follower*</sub>
6. GET    /api/v1/friendship/pending_requests <sub>*lisf of pending following request*</sub>
7. GET    /api/v1/friendship/follow_requests <sub>*list of follower request*</sub>
8. GET    /api/v1/friendship/followers <sub>*list of followers*</sub>
9. GET    /api/v1/friendship/following <sub>*list of following*</sub>

### API activities
1. GET    /api/v1/activities/lastest <sub>*get lastest activities*</sub>
2. GET    /api/v1/activities/my_friend <sub>*get friend activities*</sub>
3. GET    /api/v1/activities/:user_id <sub>*get my activities*</sub>
4. POST   /api/v1/activities <sub>*create activity*</sub>

### API clock operations
1. GET    /api/v1/clock_operations <sub>*list of clock operations*</sub>
2. POST   /api/v1/clock_operations <sub>*create clock operations*</sub>

### How to use this apps
1. install rails 7.0.4.2
2. install ruby 3.2.1
3. install redis <sub>*for cache*</sub>
4. create file with name .env <sub>*you can see the fill on example file with name env.example*</sub>
4. bundle install
5. rake db:create; rake db:migrate; rake db:seed
6. rails s

### Step by step use API
1. first hit api ```/api/v1/users``` to see available users
2. get user id on api list users to try api friendship.
   hit api ```/api/v1/friendship/follow``` with parameters
   ```{"sender_id": 1, "receiver_id": 2}```
3. user id 2 accept the request follower with api 
   ```/api/v1/friendship/accept_follow``` with parameters 
   ```{"sender_id": 2, "receiver_id": 1}```
4. list followers ```/api/v1/friendship/followers?user_id=2```
5. see list available clock operations ```/api/v1/clock_operations```
6. add new clock operations ```/api/v1/clock_operations``` with parameters
   ```{clock_at: "07:15"}```
7. save activity "good night" example user with id 2 want save he activity so you can hit this api ```/api/v1/activities``` with parameters
  ```{"user_id": 1,"sleep_at": null, "wake_up_at": "2023-03-06 05:00"}``` for the first you want save your activity you must fill parameter ```wake_up_at```. And if you want to track your hours of sleep you can fill ```sleep_at``` with format ```YYYY-MM-DD HH:MM``` or you can fill only hours and minutes ```HH:MM```
8. see friend activities ```/api/v1/activities/my_friend``` with parameter
   ```{"user_id": 1, "friend_id": 2}```
9. see my activities ```/api/v1/activities/2```
10. see my lastest activities ```/api/v1/activities/lastest?user_id=2```
### POSTMAN Documentation
https://documenter.getpostman.com/view/751267/2s93JnW7gK
