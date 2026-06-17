create table main (
                      id int primary key, --унікальне значення з primary key
                      name varchar(100), 
                      surname varchar(100),
                      email varchar(100)
); 
create table study_programs(
                               field varchar(100) primary key,
                               hardest_subject varchar(100),
                               easiest_subject varchar(100),
                               avarage_grade decimal(4,1) -- всього число може містити 4 цифри (максимальне 100.0, залишаю до 1 цифри після коми)
);
create table hobby_details(
                              years_number int primary key,
                              approximate_medals_number int,
                              hours_spent_for_hobby int
);
create table study_general_info(
                                   study_id int primary key,
                                   enrollment_year int,
                                   city varchar(100),
                                   university_name varchar(100),
                                   faculty varchar(100),
                                   foreign key(study_id) references main(id), --reference для зв'язку таблиць між собою (структура як в файлі-прикладі script.sql)
                                   foreign key(faculty) references study_programs(field)
);
create table hobbies(
                        person_id int primary key,
                        hobby varchar(100),
                        level varchar(100),
                        years_in_total int,
                        foreign key(person_id) references main(id),
                        foreign key(years_in_total) references hobby_details(years_number)
);
--заповнення таблиць
insert into main (id, name, surname, email) values
(1, 'Maria', 'Franko', 'maria@kse.org.ua'),
(2, 'Anna', 'Shevchenko', 'anna@kse.org.ua'),
(3, 'Oleg', 'Petrov', 'oleg@kse.org.ua'),
(4, 'Roman', 'Sydorenko', 'roman@kse.org.ua'),
(5, 'Vasyl', 'Yarmolenko', 'vasyl@kse.org.ua'),
(6, 'Stepan', 'Bondarenko', 'stepan@kse.org.ua');

insert into study_programs (field, hardest_subject, easiest_subject, avarage_grade) values
('Cybersecurity', 'Algorithms and data structure', 'Intro to math', 88.6),
('Psychology', 'Anatomy', 'English', 100.0),
('Law', 'Ukrainian laws', 'Math', 77.5),
('AI', 'Discrete math', 'Probability essentials', 88.9);

insert into hobby_details(years_number, approximate_medals_number, hours_spent_for_hobby) values
(1,2,120),
(2,6,240),
(3,15,400),
(4,28,550),
(5,35,700),
(6,48,850),
(7,65,1000),
(8,90,1200);

insert into study_general_info (study_id, enrollment_year, city, university_name, faculty) values
(1, 2025, 'Kyiv', 'Kyiv School of Economics', 'Cybersecurity'),
(2, 2024, 'Kyiv', 'Kyiv School of Econonmics', 'Psychology'),
(3, 2025, 'Sumy', 'SumDU', 'Law'),
(4, 2023, 'Kyiv', 'KPI', 'AI'),
(5, 2022, 'Kyiv', 'Kyiv School of Economics', 'Cybersecurity'),
(6, 2024, 'Kharkiv', 'Kharkiv Polytechnic Institute', 'AI');

insert into hobbies(person_id, hobby, level, years_in_total) values
(1, 'Dance', 'Professional', 8),
(2, 'Tennis', 'Professional', 5),
(3, 'Swimming', 'Amateur', 2),
(4, 'Volleyball', 'Amateur', 1),
(5, 'Football', 'Professional', 7),
(6, 'Karate', 'Amateur', 3);

with joining as ( --використання CTE для join 5 таблиць за спільними колонками
    select
        m.id as student_id,
        m.name,
        m.surname,
        m.email,
        sgi.city,
        sgi.faculty,
        sp.hardest_subject,
        sp.avarage_grade,
        h.hobby,
        h.level,
        hd.hours_spent_for_hobby,
        hd.years_number,
        hd.approximate_medals_number
    from main m
             join study_general_info sgi on m.id=sgi.study_id
             join study_programs sp on sgi.faculty=sp.field
             join hobbies h on m.id=h.person_id
             join hobby_details hd on h.years_in_total =hd.years_number
)
select
    name,
    surname,
    email,
    city,
    faculty,
    avarage_grade,
    hobby,
    level,
    hours_spent_for_hobby,
    approximate_medals_number
from joining --обираю найважливіші колонки з CTE
where city in ('Kyiv', 'Sumy') -- фільтрую за містами в списку
group by --групую, використовуючи всі колонки, які обрала через select 
         name,
         surname,
         email,
         city,
         faculty,
         avarage_grade,
         hobby,
         level,
         hours_spent_for_hobby,
         approximate_medals_number
order by approximate_medals_number desc --порядок спадання кількості медалей
	









	















