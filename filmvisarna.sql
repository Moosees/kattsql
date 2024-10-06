CREATE TABLE movie (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    title varchar(100) NOT NULL,
    play_time smallint unsigned NOT NULL,
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
                    "trailer": {"type": "string", "description": "A URL to play the movie trailer"}
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
    --description text
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

INSERT INTO movie (title, play_time, movie_info) VALUES
(
    'Katten i stan', 68,
    '{"year_recorded": 2000, "director": "Poe", "actors": ["Yves", "Gertrude"], "description": "Katten är i stan", "trailer": "youtube.com"}'
),
(
    'Katten på havet', 84,
    '{"year_recorded": 2007, "director": "Gertrude", "actors": ["Inte Yves", "Poe"], "description": "Katten seglar"}'
),
(
    'Kattparty', 112, null
),
(
    'Familjekatten', 99, null
),
(
    'Katten, återkomsten', 118, null
),
(
    'En katt till farsa', 76, null
),
(
    'En värsting till katt', 88, null
),
(
    'Katt, musikalen', 80, null
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

INSERT INTO auditorium (auditorium_name, description) VALUES
('Stora salen', 'Den är stor');

INSERT INTO seat (auditorium_id, seat_row, seat_num) VALUES
--stora salen
(1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 1, 4),
(1, 1, 5), (1, 1, 6), (1, 1, 7), (1, 1, 8),
(1, 2, 1), (1, 2, 2), (1, 2, 3), (1, 2, 4),
(1, 2, 5), (1, 2, 6), (1, 2, 7), (1, 2, 8), (1, 2, 9),
(1, 3, 1), (1, 3, 2), (1, 3, 3), (1, 3, 4), (1, 3, 4),
(1, 3, 6), (1, 3, 7), (1, 3, 8), (1, 3, 9), (1, 3, 10),
(1, 4, 1), (1, 4, 2), (1, 4, 3), (1, 4, 4), (1, 4, 4),
(1, 4, 1), (1, 4, 2), (1, 4, 3), (1, 4, 4), (1, 4, 4),
(1, 5, 1), (1, 5, 2), (1, 5, 3), (1, 5, 4), (1, 5, 4),
(1, 5, 6), (1, 5, 7), (1, 5, 8), (1, 5, 9), (1, 5, 10),
(1, 6, 6), (1, 6, 7), (1, 6, 8), (1, 6, 9), (1, 6, 10),
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
--member registrations
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

--non member reservations
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
(1, 8, 5),
(2, 9, 6),
(3, 6, 2),
(3, 1, 2),
(4, 3, 5),
(4, 4, 5),
(4, 5, 5);

INSERT INTO reservation_ticket
(reservation_id, ticket_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 2);
