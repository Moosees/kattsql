-- procedure to create a booking and a member if they don't exist
DELIMITER //

CREATE PROCEDURE create_reservation (IN email varchar(100), IN screeningId int unsigned)
BEGIN
	DECLARE randomResNum CHAR(6) DEFAULT UPPER(SUBSTRING(TO_BASE64(MD5(RAND())), 1 + RAND(), 6));
	DECLARE userId int;

	INSERT IGNORE INTO user (role, user_email) VALUES ('visitor', email);

	SELECT u.id INTO userId FROM user u WHERE u.user_email = email;

	INSERT INTO reservation (reservation_num, user_id, screening_id) VALUES
	(randomResNum, userId, screeningId);

	SELECT r.id as reservationId, randomResNum as reservationNum FROM reservation r WHERE r.reservation_num = randomResNum;

END //

DELIMITER ;
