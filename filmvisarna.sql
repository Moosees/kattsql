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
(1, 2);

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
('2024-10-19 19:30:00', 1, 1),
('2024-10-19 22:00:00', 2, 1),
('2024-10-20 19:30:00', 1, 1),
('2024-10-21 18:00:00', 2, 1),
('2024-10-22 19:00:00', 1, 1),
('2024-10-22 21:30:00', 1, 1);

INSERT INTO member (member_email, member_password) VALUES
('yves@yves.yves', '123'),
('gertrude@gert.rude', '123');

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
