-- Create Tables
-- Student table
CREATE TABLE Student(
    s_id VARCHAR(10),
    s_name VARCHAR(20) NOT NULL DEFAULT '',
    s_birth DATETIME NOT NULL DEFAULT now(),
    s_gender VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(s_id)
);

-- Course Table
CREATE TABLE Course(
    c_id VARCHAR(10),
    c_name VARCHAR(20) NOT NULL DEFAULT '',
    t_id VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(c_id)
);
-- Teacher Table
CREATE TABLE Teacher(
    t_id VARCHAR(10),
    t_name VARCHAR(20) NOT NULL DEFAULT '',
    PRIMARY KEY(t_id)
);
-- Transcript Table
CREATE TABLE Score(
    s_id VARCHAR(10),
    c_id VARCHAR(10),
    s_score INT(3),
    PRIMARY KEY(s_id, c_id)
);

-- Insert the data into the student table
insert into Student values('01' , 'Lei Zhao' , '1990-01-01' , 'M');
insert into Student values('02' , 'Dian Qian' , '1990-12-21' , 'M');
insert into Student values('03' , 'Feng Sun' , '1990-05-20' , 'M');
insert into Student values('04' , 'Yun Li' , '1990-08-06' , 'M');
insert into Student values('05' , 'Mei Zhou' , '1991-12-01' , 'F');
insert into Student values('06' , 'Lan Wu' , '1992-03-01' , 'F');
insert into Student values('07' , 'Zhu Zheng' , '1989-07-01' , 'F');
insert into Student values('08' , 'Ju Wang' , '1990-01-20' , 'F');

-- Course data
insert into Course values('01' , 'Chinese' , '02');
insert into Course values('02' , 'Math' , '01');
insert into Course values('03' , 'English' , '03');

-- Teacher data
insert into Teacher values('01' , 'San Zhang');
insert into Teacher values('02' , 'Si Li');
insert into Teacher values('03' , 'Wu Wang');

-- Grade data
insert into Score values('01' , '01' , 80);
insert into Score values('01' , '02' , 90);
insert into Score values('01' , '03' , 99);
insert into Score values('02' , '01' , 70);
insert into Score values('02' , '02' , 60);
insert into Score values('02' , '03' , 80);
insert into Score values('03' , '01' , 80);
insert into Score values('03' , '02' , 80);
insert into Score values('03' , '03' , 80);
insert into Score values('04' , '01' , 50);
insert into Score values('04' , '02' , 30);
insert into Score values('04' , '03' , 20);
insert into Score values('05' , '01' , 76);
insert into Score values('05' , '02' , 87);
insert into Score values('06' , '01' , 31);
insert into Score values('06' , '03' , 34);
insert into Score values('07' , '02' , 89);
insert into Score values('07' , '03' , 98);

