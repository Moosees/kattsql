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

-- view for all seats and if they are taken or not
CREATE VIEW vy_all_seats AS
SELECT m.title, s2.start_time AS startTime, s2.id AS screeningId, a.auditorium_name AS auditorium, 
(SELECT json_arrayagg(json_object('seatId',s.id ,'row', s.seat_row,'number', s.seat_num, 'free', IF(rss.reservation_id IS NULL, TRUE, FALSE)))
FROM res_seat_screen rss
RIGHT JOIN seat s ON (s.id = rss.seat_id AND rss.screening_id = screeningId)) AS seats
FROM screening s2
JOIN movie m ON m.id = s2.movie_id
JOIN auditorium a ON a.id = s2.auditorium_id;
