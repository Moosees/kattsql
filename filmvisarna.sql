SET @movie_info = '{
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
}';

CREATE TABLE movie (
    id int unsigned AUTO_INCREMENT PRIMARY KEY,
    title varchar(100) NOT NULL,
    play_time smallint unsigned NOT NULL,
    original_title varchar(100),
    year_recorded date,
    director varchar(50),
    actors_cat varchar(255),
    description text,
    trailer_url varchar(100)
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

INSERT INTO movie
(
    id, title, play_time, original_title, year_recorded,
    director, actors_cat, description, trailer_url
)
VALUES
(
    0, 'Katten i stan', 123, null, '2000-01-01', 'Poe', 'Yves, Gertrude',
    'Katten är i stan', 'youtube.com'
),
(
    0, 'Katten på havet', 322, null, '2007-01-01', 'Gertrude', 'Inte Yves, Poe',
    'Katten seglar', 'youtube.com'
);

INSERT INTO genre (id, genre_name) VALUES
(0, 'Action'),
(0, 'Rysare');

INSERT INTO genre_movie (genre_id, movie_id) VALUES
(1, 2),
(2, 1);

INSERT INTO event (id, title, description) VALUES
(0, 'Kattsommar', 'Kallt men varmt');

INSERT INTO event_movie (event_id, movie_id) VALUES
(1, 2);

INSERT INTO ticket (id, ticket_name, price) VALUES
(0, 'Vuxen', 321),
(0, 'Barn', 123);

INSERT INTO auditorium (id, auditorium_name, description) VALUES
(0, 'Stora salen', 'Den är stor');

INSERT INTO seat (id, auditorium_id, seat_row, seat_num) VALUES
(0, 1, 1, 1),
(0, 1, 1, 2),
(0, 1, 2, 1),
(0, 1, 2, 2),
(0, 1, 2, 3),
(0, 1, 3, 1),
(0, 1, 3, 2),
(0, 1, 3, 3),
(0, 1, 4, 1),
(0, 1, 4, 2),
(0, 1, 4, 3),
(0, 1, 4, 4);

INSERT INTO screening (id, start_time, movie_id, auditorium_id) VALUES
(0, '2024-10-19 19:30:00', 1, 1),
(0, '2024-10-19 22:00:00', 2, 1),
(0, '2024-10-20 19:30:00', 1, 1),
(0, '2024-10-21 18:00:00', 2, 1),
(0, '2024-10-22 19:00:00', 1, 1),
(0, '2024-10-22 21:30:00', 1, 1);

INSERT INTO member (id, member_email, member_password) VALUES
(0, 'yves@yves.yves', '123'),
(0, 'gertrude@gert.rude', '123');

INSERT INTO reservation (id, reservation_num, member_id, screening_id) VALUES
(0, '653GGG', 1, 5),
(0, 'UIF525', 1, 6),
(0, '963SAA', 2, 2),
(0, 'TRRrBb', 2, 5);

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
