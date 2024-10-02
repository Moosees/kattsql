CREATE TABLE movie (
    id int AUTO_INCREMENT PRIMARY KEY,
    title varchar(100) NOT NULL,
    play_time int NOT NULL,
    original_title varchar(100),
    year_recorded date,
    director varchar(50),
    actors_cat varchar(255),
    description text,
    trailer_url varchar(100)
);

CREATE TABLE genre (
    id int AUTO_INCREMENT PRIMARY KEY,
    genre_name varchar(30) NOT NULL
);

CREATE TABLE genre_movie (
    genre_id int,
    movie_id int,
    PRIMARY KEY (genre_id, movie_id),
    CONSTRAINT fk_genre FOREIGN KEY (genre_id)
    REFERENCES genre (id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id)
    REFERENCES movie (id)
);

CREATE TABLE event (
    id int AUTO_INCREMENT PRIMARY KEY,
    title varchar(30) NOT NULL,
    description text NOT NULL
);

CREATE TABLE event_movie (
    event_id int,
    movie_id int,
    PRIMARY KEY (event_id, movie_id),
    CONSTRAINT fk_event FOREIGN KEY (event_id)
    REFERENCES event (id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id)
    REFERENCES movie (id)
);

CREATE TABLE ticket (
    id int AUTO_INCREMENT PRIMARY KEY,
    ticket_name varchar(30) NOT NULL,
    price int NOT NULL
);

CREATE TABLE auditorium (
    id int AUTO_INCREMENT PRIMARY KEY,
    auditorium_name varchar(30) NOT NULL,
    description text
);

CREATE TABLE seat (
    id int AUTO_INCREMENT PRIMARY KEY,
    auditorium_id int NOT NULL,
    seat_row int NOT NULL,
    seat_num int NOT NULL,
    CONSTRAINT fk_auditorium FOREIGN KEY (auditorium_id)
    REFERENCES auditorium (id)
);

CREATE TABLE screening (
    id int AUTO_INCREMENT PRIMARY KEY,
    start_time datetime NOT NULL,
    movie_id int NOT NULL,
    auditorium_id int NOT NULL,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id)
    REFERENCES movie (id),
    CONSTRAINT fk_auditorium FOREIGN KEY (fk_auditorium)
    REFERENCES auditorium (id)
);

CREATE TABLE member (
    id int AUTO_INCREMENT PRIMARY KEY,
    member_email varchar(100),
    member_password varchar(255)
);

CREATE TABLE reservation (
    id int AUTO_INCREMENT PRIMARY KEY,
    reservation_num varchar(20),
    member_id int NOT NULL,
    auditorium_id int NOT NULL,
    movie_id int NOT NULL,
    CONSTRAINT fk_member FOREIGN KEY (user_id)
    REFERENCES member (id),
    CONSTRAINT fk_auditorium FOREIGN KEY (auditorium_id)
    REFERENCES auditorium (id),
    CONSTRAINT fk_movie FOREIGN KEY (movie_id)
    REFERENCES movie (id)
);

CREATE TABLE reservation_seat (
    reservation_id int NOT NULL,
    seat_id int NOT NULL,
    PRIMARY KEY (reservation_id, seat_id),
    CONSTRAINT fk_reservation FOREIGN KEY (reservation_id)
    REFERENCES reservation (id),
    CONSTRAINT fk_seat FOREIGN KEY (seat_id)
    REFERENCES seat (id)
);

CREATE TABLE reservation_ticket (
    reservation_id int NOT NULL,
    ticket_id int NOT NULL,
    ticket_quantity int NOT NULL,
    PRIMARY KEY (reservation_id, ticket_id),
    CONSTRAINT fk_reservation FOREIGN KEY (reservation_id)
    REFERENCES reservation (id),
    CONSTRAINT fk_ticket FOREIGN KEY (ticket_id)
    REFERENCES ticket (id)
);
