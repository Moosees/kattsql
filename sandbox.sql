-- procedure to create a booking and a member if they don't exist
DELIMITER //

CREATE PROCEDURE create_reservation (IN email varchar(100), IN screeningId int unsigned, OUT reservationId int unsigned)
BEGIN
	DECLARE randomResNum CHAR(6) DEFAULT UPPER(SUBSTRING(TO_BASE64(MD5(RAND())), 1 + RAND(), 6));
	DECLARE memberId int;

	INSERT IGNORE INTO member (member_email) VALUES (email);

	SELECT m.id INTO memberId FROM member m WHERE m.member_email = email;

	INSERT INTO reservation (reservation_num, member_id, screening_id) VALUES
	(randomResNum, memberId, screeningId);

	SELECT r.id INTO reservationId FROM reservation r WHERE r.reservation_num = randomResNum;

END //

DELIMITER ;
