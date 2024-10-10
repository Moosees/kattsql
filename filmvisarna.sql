CREATE TABLE movie (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    url_param varchar(50) NOT NULL UNIQUE,
    title varchar(100) NOT NULL,
    play_time smallint unsigned NOT NULL,
    age smallint unsigned NOT NULL,
    movie_info json,
    CHECK (
        JSON_SCHEMA_VALID (
            '{
                "$schema": "https://json-schema.org/draft/2020-12/schema",
                "title": "Movie info",
                "description": "Various misc info about a movie",
                "type": "object",
                "properties": {
                    "original_title": {"type": "string"},
                    "year_recorded": {"type": "integer"},
                    "director": {"type": "string"},
                    "actors": {"type": "array", "items": {"type": "string"}},
                    "description": {"type": "string"},
                    "trailer": {"type": "string", "description": "A URL to play the movie trailer"},
                    "poster": {"type": "string"}
                }
            }',
            movie_info
        )
    )
);

CREATE TABLE genre (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    genre_name varchar(30) NOT NULL
);

CREATE TABLE genre_movie (
    genre_id int unsigned,
    movie_id int unsigned,
    PRIMARY KEY (genre_id, movie_id),
    FOREIGN KEY (genre_id) REFERENCES genre (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);

CREATE TABLE event (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    title varchar(30) NOT NULL,
    description text NOT NULL
);

CREATE TABLE event_movie (
    event_id int unsigned,
    movie_id int unsigned,
    PRIMARY KEY (event_id, movie_id),
    FOREIGN KEY (event_id) REFERENCES event (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);

CREATE TABLE ticket (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    ticket_name varchar(30) NOT NULL,
    price smallint unsigned NOT NULL
);

CREATE TABLE auditorium (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    auditorium_name varchar(30) NOT NULL
);

CREATE TABLE seat (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    auditorium_id int unsigned,
    seat_row int unsigned,
    seat_num int unsigned,
    FOREIGN KEY (auditorium_id) REFERENCES auditorium (id)
);

CREATE TABLE screening (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    start_time datetime NOT NULL,
    movie_id int unsigned,
    auditorium_id int unsigned,
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (auditorium_id) REFERENCES auditorium (id)
);

CREATE TABLE member (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    member_email varchar(100) UNIQUE NOT NULL,
    member_password varchar(255),
    first_name varchar(100),
    last_name varchar(100)
);

CREATE TABLE reservation (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    reservation_num varchar(20) NOT NULL,
    member_id int unsigned,
    screening_id int unsigned,
    FOREIGN KEY (member_id) REFERENCES member (id),
    FOREIGN KEY (screening_id) REFERENCES screening (id)
);

CREATE TABLE res_seat_screen (
    reservation_id int unsigned,
    seat_id int unsigned,
    screening_id int unsigned,
    PRIMARY KEY (seat_id, screening_id),
    FOREIGN KEY (reservation_id) REFERENCES reservation (id),
    FOREIGN KEY (seat_id) REFERENCES seat (id),
    FOREIGN KEY (screening_id) REFERENCES screening (id)
);

CREATE TABLE reservation_ticket (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    reservation_id int unsigned,
    ticket_id int unsigned,
    FOREIGN KEY (reservation_id) REFERENCES reservation (id),
    FOREIGN KEY (ticket_id) REFERENCES ticket (id)
);

INSERT INTO movie (title, url_param, play_time, age, movie_info) VALUES
(
    'Katten i stan', 'katten-i-stan', 68, 15,
    '{"year_recorded": 2000, "director": "Poe", "actors": ["Yves", "Gertrude"], "description": "Katten är i stan", "trailer": "youtube.com"}'
),
(
    'Katten på havet', 'katten-pa-havet', 84, 15,
    '{"year_recorded": 2007, "director": "Gertrude", "actors": ["Inte Yves", "Poe"], "description": "Katten seglar"}'
),
(
    'Kattparty', 'kattparty', 112, 15, null
),
(
    'Familjekatten', 'familjekatten', 99, 7, null
),
(
    'Katten, återkomsten', 'katten-aterkomsten', 118, 11, null
),
(
    'En katt till farsa', 'en-katt-till-farsa', 76, 11, null
),
(
    'En värsting till katt', 'en-varsting-till-katt', 88, 7, null
),
(
    'Katt, musikalen', 'katt-musikalen', 80, 15, null
);

INSERT INTO genre (genre_name) VALUES
('Action'),
('Rysare'),
('Fantasy'),
('Komedi'),
('Skräck'),
('Drama'),
('Dokumentär'),
('Science fiction');

INSERT INTO genre_movie (movie_id, genre_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 5),
(4, 6),
(5, 5),
(5, 8),
(6, 4),
(7, 4),
(8, 8),
(8, 4);

INSERT INTO event (title, description) VALUES
('Kattsommar', 'Kallt men varmt');

INSERT INTO event_movie (event_id, movie_id) VALUES
(1, 2),
(1, 5),
(1, 8);

INSERT INTO ticket (ticket_name, price) VALUES
('Vuxen', 140),
('Barn', 80),
('Senior', 120);

INSERT INTO auditorium (auditorium_name) VALUES
('Stora salongen'),
('Lilla salongen');

INSERT INTO seat (auditorium_id, seat_row, seat_num) VALUES
(1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 1, 4),
(1, 1, 5), (1, 1, 6), (1, 1, 7), (1, 1, 8),
(1, 2, 1), (1, 2, 2), (1, 2, 3), (1, 2, 4),
(1, 2, 5), (1, 2, 6), (1, 2, 7), (1, 2, 8), (1, 2, 9),
(1, 3, 1), (1, 3, 2), (1, 3, 3), (1, 3, 4), (1, 3, 5),
(1, 3, 6), (1, 3, 7), (1, 3, 8), (1, 3, 9), (1, 3, 10),
(1, 4, 1), (1, 4, 2), (1, 4, 3), (1, 4, 4), (1, 4, 5),
(1, 4, 6), (1, 4, 7), (1, 4, 8), (1, 4, 9), (1, 4, 10),
(1, 5, 1), (1, 5, 2), (1, 5, 3), (1, 5, 4), (1, 5, 5),
(1, 5, 6), (1, 5, 7), (1, 5, 8), (1, 5, 9), (1, 5, 10),
(1, 6, 1), (1, 6, 2), (1, 6, 3), (1, 6, 4), (1, 6, 5),
(1, 6, 6), (1, 6, 7), (1, 6, 8), (1, 6, 9), (1, 6, 10),
(1, 7, 1), (1, 7, 2), (1, 7, 3), (1, 7, 4),
(1, 7, 5), (1, 7, 6), (1, 7, 7), (1, 7, 8),
(1, 7, 9), (1, 7, 10), (1, 7, 11), (1, 7, 12),
(1, 8, 1), (1, 8, 2), (1, 8, 3), (1, 8, 4),
(1, 8, 5), (1, 8, 6), (1, 8, 7), (1, 8, 8),
(1, 8, 9), (1, 8, 10), (1, 8, 11), (1, 8, 12);

INSERT INTO screening (start_time, movie_id, auditorium_id) VALUES
('2024-11-01 18:30:00', 1, 1),
('2024-11-01 22:00:00', 5, 1),
('2024-11-02 11:45:00', 6, 1),
('2024-11-02 14:30:00', 7, 1),
('2024-11-02 18:45:00', 2, 1),
('2024-11-02 22:15:00', 3, 1),
('2024-11-03 12:00:00', 1, 1),
('2024-11-03 15:00:00', 2, 1),
('2024-11-03 21:45:00', 8, 1),
('2024-11-04 16:00:00', 7, 1),
('2024-11-04 21:00:00', 1, 1),
('2024-11-05 12:45:00', 2, 1),
('2024-11-05 15:15:00', 4, 1),
('2024-11-05 21:30:00', 1, 1),
('2024-11-06 17:00:00', 6, 1),
('2024-11-06 20:15:00', 8, 1),
('2024-11-07 15:30:00', 1, 1),
('2024-11-07 19:45:00', 5, 1),
('2024-11-08 18:00:00', 8, 1),
('2024-11-08 22:30:00', 3, 1),
('2024-11-09 10:45:00', 5, 1),
('2024-11-09 13:30:00', 6, 1),
('2024-11-09 18:00:00', 1, 1),
('2024-11-09 21:15:00', 2, 1),
('2024-11-10 11:00:00', 3, 1),
('2024-11-10 13:30:00', 5, 1),
('2024-11-10 17:45:00', 6, 1),
('2024-11-10 21:30:00', 1, 1),
('2024-11-11 17:00:00', 7, 1),
('2024-11-11 21:45:00', 2, 1),
('2024-11-12 18:15:00', 6, 1),
('2024-11-12 22:00:00', 7, 1),
('2024-11-13 16:00:00', 2, 1),
('2024-11-13 20:45:00', 5, 1);

INSERT INTO member (member_email, member_password, first_name, last_name) VALUES
('yves@maila.se', '123', 'Yves', 'Bananums'),
('gertrude@gertrude.org', '123', 'Gertrude', 'Bananums'),
('johan.olsson@exempel.se', '123', 'Johan', 'Olsson'),
('elin.persson@domän.se', '123', 'Elin', 'Persson'),
('mats.nilsson@webbpost.se', '123', 'Mats', 'Nilsson'),
('sara.karlsson@tjänst.net', '123', 'Sara', 'Karlsson'),
('emil.svensson@minemail.org', '123', 'Emil', 'Svensson'),
('linda.larsson@domän.org', '123', 'Linda', 'Larsson'),
('oskar.johansson@snabbmail.se', '123', 'Oskar', 'Johansson'),
('kristin.andersson@online.se', '123', 'Kristin', 'Andersson'),
('anton.eriksson@brevlåda.com', '123', 'Anton', 'Eriksson');

INSERT INTO member (member_email) VALUES
('sofie.nilsson@mittdomän.se'),
('viktor.holm@webbmail.net'),
('julia.fredriksson@företag.org'),
('isak.lindgren@affär.net'),
('agnes.söderberg@tjänst.com'),
('linnea.hansson@kontor.com'),
('lucas.berglund@nyemail.org'),
('hanna.nyström@snabbpost.net'),
('mia.fransson@domän.net'),
('gustav.sandberg@företag.com'),
('ida.wikström@minemail.net'),
('henrik.lund@webbtjänst.com'),
('emma.berg@mejla.org'),
('adam.pettersson@domänmail.com'),
('alice.sundström@info.se'),
('leo.ahlgren@företagsmail.org'),
('klara.ström@tjänst.org'),
('max.blom@webbemail.net'),
('vilma.andreasson@internetmail.com'),
('oskar.dahl@affärsmail.net'),
('nora.sjölund@onlinemail.se');

INSERT INTO reservation (reservation_num, member_id, screening_id) VALUES
('A35VGF', 1, 1),
('Q9HJ8T', 1, 9),
('R4C7YD', 1, 17),
('Z5F1KL', 1, 22),
('K7P1HD', 2, 2),
('M8C3XJ', 2, 6),
('V5T9LR', 2, 10),
('W6H7QB', 2, 14),
('G4D5ZN', 2, 23),
('J3N7WK', 3, 3),
('C8J4DY', 3, 15),
('H6T1PC', 3, 24),
('Z1K6HV', 4, 4),
('M9L7WR', 4, 8),
('N4V3YG', 4, 16),
('F7C9KD', 4, 20),
('R6J1TX', 4, 25),
('Q8J9ZX', 5, 5),
('H7K4VN', 5, 9),
('G2L8RP', 5, 13),
('T6F3KC', 5, 17),
('N2M3YB', 6, 6),
('X4V9FT', 6, 10),
('K7L2PJ', 6, 14),
('Y5B6DR', 6, 18),
('F9C1TN', 6, 22),
('J6G4HK', 6, 27),
('L5J8RF', 7, 7),
('V3K9MP', 7, 11),
('Z6X2YN', 7, 15),
('B4H3TL', 7, 19),
('C7V9JD', 7, 23),
('P2F1GK', 7, 28),
('M1K4XD', 8, 8),
('R5T6PC', 8, 29),
('Y7B3NK', 9, 1),
('N4F8JL', 9, 9),
('X2V7GK', 9, 17),
('G5C1YR', 9, 25),
('H3D9LT', 9, 30),
('T6K2JP', 9, 21),
('P4J8KL', 10, 10),
('K2T5GC', 10, 18),
('L3F9NV', 10, 26),
('M1V7YK', 10, 31),
('Z8H2PX', 10, 22),
('C2K5DR', 11, 3),
('V6L8FP', 11, 11),
('R9T1GH', 11, 19),
('B7J4NK', 11, 27),
('X3F9YC', 11, 32),
('H8M6PJ', 11, 23),
('H8L5TX', 12, 15),
('C9V3JD', 12, 29),
('X4F1KL', 13, 3),
('W6T8PD', 13, 16),
('P2J9XR', 13, 30),
('Z8K9VR', 14, 4),
('J6F3DX', 15, 5),
('L9V7WP', 15, 18),
('B4N8YC', 15, 32),
('V5R9TL', 16, 19),
('H2F7PC', 16, 20),
('F9N4WT', 17, 7),
('C3B5JP', 17, 13),
('X1V6LK', 17, 24),
('G2P9RF', 18, 8),
('S7F2VL', 19, 9),
('N1C5TR', 19, 25),
('D8V3FK', 20, 10),
('Q5L9MP', 20, 23),
('H2T1RC', 20, 26),
('Y9B4NK', 21, 11),
('P6M3JD', 21, 14),
('X2C5RP', 21, 27),
('F6T9KL', 22, 12),
('N1P3VX', 22, 15),
('M5L7PC', 23, 13),
('T7X6LN', 24, 1),
('P3F5CJ', 24, 17),
('H9R2BK', 24, 30),
('X8C4TD', 25, 2),
('W7N5KP', 25, 18),
('N5T7LR', 26, 3),
('M9L8XF', 26, 19),
('D2C4JP', 26, 32),
('J6R9VP', 27, 4),
('K4F9TR', 28, 5),
('L1M7CX', 28, 22),
('T2B3LP', 28, 24),
('R7J8VL', 29, 6),
('M2L1FT', 29, 25),
('W9T4PD', 30, 7),
('D3V6LX', 30, 24),
('X1B5KP', 30, 26),
('F5L7GN', 31, 8),
('N4M1VC', 31, 25),
('P3T2JK', 31, 27),
('H2F8PL', 32, 26),
('B1M4XC', 32, 28);

INSERT INTO res_seat_screen (reservation_id, seat_id, screening_id) VALUES
(1, 63, 1),
(36, 51, 1),
(36, 52, 1),
(36, 53, 1),
(79, 42, 1),
(79, 43, 1),
(5, 63, 2),
(82, 52, 2),
(10, 61, 3),
(10, 62, 3),
(10, 63, 3),
(10, 64, 3),
(47, 52, 3),
(55, 42, 3),
(84, 32, 3),
(13, 63, 4),
(58, 52, 4),
(87, 42, 4),
(18, 63, 5),
(59, 51, 5),
(59, 52, 5),
(59, 53, 5),
(88, 42, 5),
(6, 63, 6),
(22, 52, 6),
(91, 42, 6),
(28, 63, 7),
(64, 52, 7),
(93, 42, 7),
(14, 63, 8),
(34, 52, 8),
(34, 53, 8),
(34, 54, 8),
(34, 55, 8),
(67, 42, 8),
(96, 32, 8),
(96, 31, 8),
(2, 63, 9),
(19, 52, 9),
(37, 42, 9),
(68, 32, 9),
(7, 63, 10),
(23, 52, 10),
(42, 42, 10),
(70, 32, 10),
(29, 63, 11),
(48, 51, 11),
(48, 52, 11),
(48, 53, 11),
(48, 54, 11),
(48, 55, 11),
(73, 42, 11),
(76, 63, 12),
(20, 63, 13),
(65, 52, 13),
(78, 42, 13),
(8, 62, 14),
(8, 63, 14),
(24, 52, 14),
(74, 42, 14),
(74, 41, 14),
(11, 63, 15),
(30, 52, 15),
(53, 44, 15),
(53, 45, 15),
(53, 46, 15),
(77, 32, 15),
(15, 63, 16),
(56, 52, 16),
(3, 63, 17),
(21, 52, 17),
(38, 42, 17),
(80, 32, 17),
(25, 60, 18),
(25, 61, 18),
(43, 51, 18),
(43, 52, 18),
(60, 42, 18),
(83, 32, 18),
(31, 63, 19),
(49, 52, 19),
(62, 42, 19),
(85, 30, 19),
(85, 31, 19),
(85, 32, 19),
(16, 63, 20),
(63, 52, 20),
(41, 63, 21),
(4, 63, 22),
(26, 52, 22),
(46, 42, 22),
(89, 32, 22),
(9, 63, 23),
(32, 52, 23),
(52, 40, 23),
(52, 41, 23),
(52, 42, 23),
(71, 32, 23),
(71, 33, 23),
(71, 34, 23),
(71, 35, 23),
(71, 36, 23),
(71, 37, 23),
(12, 63, 24),
(66, 52, 24),
(90, 42, 24),
(94, 32, 24),
(17, 63, 25),
(39, 52, 25),
(69, 42, 25),
(92, 32, 25),
(97, 22, 25),
(44, 63, 26),
(72, 52, 26),
(72, 51, 26),
(95, 42, 26),
(99, 32, 26),
(27, 63, 27),
(50, 52, 27),
(75, 42, 27),
(98, 32, 27),
(33, 61, 28),
(33, 60, 28),
(33, 59, 28),
(100, 52, 28),
(35, 63, 29),
(54, 52, 29),
(40, 63, 30),
(57, 52, 30),
(81, 42, 30),
(45, 63, 31),
(45, 64, 31),
(51, 63, 32),
(61, 52, 32),
(86, 42, 32);

INSERT INTO reservation_ticket
(reservation_id, ticket_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(8, 1),
(9, 1),
(10, 1),
(10, 3),
(10, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 3),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(25, 1),
(26, 1),
(27, 2),
(28, 2),
(29, 2),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(33, 1),
(33, 1),
(34, 1),
(34, 3),
(34, 2),
(34, 1),
(35, 1),
(36, 1),
(36, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 2),
(40, 2),
(41, 1),
(42, 1),
(43, 1),
(43, 1),
(44, 1),
(45, 1),
(45, 1),
(46, 1),
(47, 2),
(48, 2),
(48, 1),
(48, 1),
(48, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(52, 3),
(52, 1),
(53, 1),
(53, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 3),
(57, 1),
(58, 3),
(59, 3),
(59, 3),
(59, 1),
(60, 2),
(61, 2),
(62, 1),
(63, 1),
(64, 2),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(71, 3),
(71, 1),
(71, 2),
(71, 2),
(71, 2),
(72, 1),
(72, 3),
(73, 1),
(74, 1),
(74, 1),
(75, 3),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 3),
(85, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 3),
(94, 2),
(95, 3),
(96, 1),
(96, 2),
(97, 2),
(98, 3),
(99, 2),
(100, 1);
