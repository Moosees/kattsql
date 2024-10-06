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
    'Katten i stan', 123,
    '{"year_recorded": 2000, "director": "Poe", "actors": ["Yves", "Gertrude"], "description": "Katten är i stan", "trailer": "youtube.com"}'
),
(
    'Katten på havet', 193,
    '{"year_recorded": 2007, "director": "Gertrude", "actors": ["Inte Yves", "Poe"], "description": "Katten seglar"}'
),
(
    'Kattparty', 169, null
),
(
    'Familjekatten', 132, null
),
(
    'Katten, återkomsten', 211, null
),
(
    'En katt till farsa', 99, null
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
('653GGG', 1, 5),
('UIF525', 1, 6),
('963SAA', 2, 2),
('TRRrBb', 2, 5);

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
