-- DATABASE CREATION:

CREATE database restaurantApp;

CREATE TABLE group (
id INT (11) NOT NULL AUTO_INCREMENT, 
name VARCHAR (100), 
startHour TIMESTAMP NOT NULL, 
endHour TIMESTAMP NOT NULL,
constraint pk_group PRIMARY KEY (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;



CREATE TABLE user (
id INT (11) NOT NULL AUTO_INCREMENT, 
userName VARCHAR (100) NOT NULL,
icon VARCHAR (200), 
upvoteNum INT (11) NOT NULL, 
groupId INT (11) NOT NULL,
constraint pk_user PRIMARY KEY (id),
constraint fk_group_1 FOREIGN KEY (groupId) REFERENCES group (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE restaurant (
id INT (11) NOT NULL AUTO_INCREMENT,
type VARCHAR (200) NOT NULL, 
name VARCHAR (200) NOT NULL,
avgPricePerson VARCHAR (50) NOT NULL,
location VARCHAR (200) NOT NULL,
userRating DOUBLE (3, 1) NOT NULL,
googleRating DOUBLE (3, 1) NOT NULL,
constraint pk_restaurant PRIMARY KEY (id)
)
 Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE menu (
id INT (11) NOT NULL AUTO_INCREMENT,
startDate DATE NOT NULL,
endDate NOT NULL, 
restaurantId INT (11) NOT NULL,
constraint pk_Menu PRIMARY KEY (id),
constraint fk_restaurant_1 FOREIGN KEY (restaurantId) REFERENCES restaurant (id)
)
 Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE dayMenu (
id INT (11) NOT NULL AUTO_INCREMENT,
price DOUBLE (5, 2),
picture VARCHAR (300) NOT NULL,
description VARCHAR (400),
restaurantId INT (11) NOT NULL,
constraint pk_dayMenu PRIMARY KEY (id),
constraint fk_restaurant_2 FOREIGN KEY (restaurantId) REFERENCES restaurant (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE menuItem (
id INT (11) NOT NULL AUTO_INCREMENT,
name VARCHAR (100) NOT NULL, 
description VARCHAR (400), 
type VARCHAR (50), 
unitPrice DOUBLE (14, 2) NOT NULL,
menuId INT (11) NOT NULL, 
constraint pk_menuItem PRIMARY KEY (id),
constraint fk_menu_1 FOREIGN KEY (menuId) REFERENCES menu (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;



CREATE TABLE groupCart (
id INT (11) NOT NULL AUTO_INCREMENT,
totalPrice DOUBLE  (20, 2) NOT NULL,
constraint pk_groupCart PRIMARY KEY (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;



CREATE TABLE userCart (
id INT (11) NOT NULL AUTO_INCREMENT,
userId INT (11) NOT NULL,
totalPrice DOUBLE (20, 2) NOT NULL, 
groupCartId INT (11) NOT NULL,
constraint pk_userCart PRIMARY KEY (id),
constraint fk_user_1 FOREIGN KEY (userId) REFERENCES user (id),
constraint fk_groupCart FOREIGN KEY (groupCartId) REFERENCES groupCart (id)

) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE recommendation (
id INT (11) NOT NULL AUTO_INCREMENT, 
text VARCHAR (400),
icon VARCHAR (100), 
stars DOUBLE (2, 1) NOT NULL, 
restaurantId INT (11) NOT  NULL,
constraint pk_recommendation PRIMARY KEY (id),
constraint fk_restaurant_3 FOREIGN KEY (restaurantId) REFERENCES restaurant (id)

) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE upvote (
id INT (11) NOT NULL AUTO_INCREMENT,
text VARCHAR (400), 
recommendationId INT (11) NOT NULL, 
restaurantId INT (11) NOT NULL, 
constraint pk_upvote PRIMARY KEY (id),
constraint fk_recommendation_1 FOREIGN KEY (recommendationId) REFERENCES recommendation (id),
constraint fk_restaurant_4 FOREIGN KEY (restaurantId) REFERENCES restaurant(id)

) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;






CREATE TABLE cartItem (
id INT (11) NOT NULL AUTO_INCREMENT, 
divNumber INT (3) NOT NULL, -- (Share number)
userCartId INT (11) NOT NULL,
userId INT (11) NOT NULL, 
menuItemId INT (11), -- I would need to make sure that if one of the items id is NULL the other one isn’t
dayMenuId INT (11),
constraint pk_cartItem PRIMARY KEY (id),
constraint fk_userCart_1 FOREIGN KEY (userCartId, userId) REFERENCES userCart (id, userId),
constraint fk_menuItem FOREIGN KEY (menuItemId) REFERENCES menuItem (id),
constraint fk_dayMenu FOREIGN KEY (dayMenuId) REFERENCES dayMenu (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;



-- I think I need to have a foreign key related with the group cart, this way, if there are two instances of the same item with different user cart’s ids, but with the same group cart, and with the division number on 2 or 3, we know that this item is shared between those 2 or 3 users, if there are more, this will still happen right??? CHECK IT pls
(I think the division number would take care of the possible problems buuut)
I could also replace the division number for a ‘SHARED’ option, this way, if 3 users hit share, the price will be divided by them, the problem there is that if 3 ppl wanna share a plate, and then another 2 want to share the same plate, I would have a problem to differentiate this, since the app would only be able to tell that the certain plate wants to be shared by 5 ppl.


CREATE TABLE medal (
id INT (11) NOT NULL AUTO_INCREMENT, 
title VARCHAR (300) NOT NULL, 
icon VARCHAR (100) NOT NULL, 
description VARCHAR (300) NOT NULL,
constraint pk_medal PRIMARY KEY (id)
) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;


CREATE TABLE medal-user ()









CREATE TABLE ranking_google (
type VARCHAR (100) NOT NULL,
restaurantId INT (11) NOT NULL, 
rankingNumber INT (11) NOT NULL,
constraint pk_rankingGoogle PRIMARY KEY (type),
constraint fk_restaurant_5 FOREIGN KEY (restaurantId) REFERENCES restaurant (id)

) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;

CREATE TABLE ranking_app ( 
type VARCHAR (100) NOT NULL , 
restaurantId INT (11) NOT NULL, 
rankingNumberINT (11) NOT NULL,
constraint pk_rankingApp PRIMARY KEY (type),
constraint fk_restaurant_6 FOREIGN KEY (restaurantId) REFERENCES restaurant (id)

) Engine = InnoDB default charset = utf8mb4 collate = utf8mb4_spanish2_ci;
