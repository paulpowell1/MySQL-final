-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(45) NOT NULL,
  `departmentabbr` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_department_college1_idx` ON `university`.`department` (`college_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` VARCHAR(45) NOT NULL,
  `course` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `course_abreviation` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_course_department1_idx` ON `university`.`course` (`department_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR NOT NULL,
  `term` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `capacity` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `section_num` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_section_faculty1_idx` ON `university`.`section` (`faculty_id` ASC) VISIBLE;

CREATE INDEX `fk_section_term1_idx` ON `university`.`section` (`term_id` ASC) VISIBLE;

CREATE INDEX `fk_section_course1_idx` ON `university`.`section` (`course_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `dob` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrolment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrolment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrolment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  CONSTRAINT `fk_section_has_student_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_section_has_student_student1_idx` ON `university`.`enrolment` (`student_id` ASC) VISIBLE;

CREATE INDEX `fk_section_has_student_section1_idx` ON `university`.`enrolment` (`section_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use university;

-- college names
insert into college (college_name) 
values ("College of Physical Science and Engineering"), 
("College of Business and Communication"), 
("College of Language and Letters");
-- departments 
insert into department (department, departmentabbr, college_id)
values 
("Computer Information Technology", "CIT", 1),
("Ecenomics", "ECON", 2), 
("Humanities and Philosophy", "HUM", 3);
-- course 
insert into course (course_num, course, credits, course_abreviation, department_id)
values 
("111", "Intro to Databases", 3, "CIT 111", 1),
("388", "Econometrics", 4, "ECON 388", 2),
("150", "Micro Economics", 3, "ECON 150", 2),
("376", "Classical Heritage", 2, "HUM 376", 3);
-- term 
insert into term (year, term)
values 
(2019, "fall"),
(2018, "Winter");
insert into faculty (fname, lname)
values 
("Marty", "Morrning"), 
("Nate", "Nathan"), 
("Ben", "Barrus"), 
("John", "Jensen"), 
("Bill", "Barney"); 
insert into section (capacity, faculty_id, term_id, course_id, section_num)
values
(30, 1, 1, 1, 1),
(50, 2, 1, 3, 1),
(50, 2, 1, 3, 2),
(35, 3, 1, 2, 1),
(30, 4, 1, 4, 1),
(30, 1, 2, 1, 2),
(35, 5, 2, 1, 3),
(50, 2, 2, 3, 1),
(50, 2, 2, 3, 2),
(30, 4, 2, 4, 1);
insert into student (fname, lname, gender, city, state, dob)
values 
("Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
("Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
("Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
("Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
("Mandy", "Murdok", "F", "Topeka", "KS", "1996-11-22"),
("Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
("Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
("Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
("Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
("Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09"); 
insert into enrolment (student_id, section_id)
values
(6,7),
(7,6),
(7,9),
(7,10),
(4,5),
(9,8),
(2,4),
(3,4),
(5,4),
(5,5),
(1,1),
(1,2),
(8,8),
(10,6);

use university;
-- Q1 
select fname, lname, date_format(dob, "%M %d %Y") as "Sept Birthdays"
from student 
where MONTHNAME(dob) = "September";
-- Q2
select lname, fname, 
floor(DATEDIFF("2017-01-05",dob)/365) AS Years, 
floor(mod(DATEDIFF("2017-01-05",dob), 365)) as days,
concat(round(DATEDIFF("2017-01-05",dob)/365)," -Yrs", " ", round(mod(DateDiff("2017-01-05",dob), 365)), " -days") as "Years and days"
from student
order by years desc;
-- Q3
select distinct s.fname, s.lname
from student as s
left join enrolment as e
on s.student_id = e.student_id
left join section as se
on se.section_id = e.section_id
left join faculty as f
on f.faculty_id = se.faculty_id
where f.faculty_id = 4
order by lname;
-- Q4
select distinct f.fname, f.lname
from faculty as f
left join section as s
on f.faculty_id = s.faculty_id
left join enrolment as e
on e.section_id = s.section_id
left join student as st
on st.student_id = e.student_id
where st.student_id = 7
order by lname;
-- Q5
select st.fname, st.lname
from section as s
left join enrolment as e
on s.section_id = e.section_id
left join student as st
on e.student_id = st.student_id 
where course_id = 2 and term_id = 1
order by lname; 
-- Q6
select departmentabbr as "department_code", course_num, course 
from department as d
left join course as c
on d.department_id = c.department_id
left join section as s
on c.course_id = s.course_id
left join enrolment as e
on s.section_id = e.section_id
left join student as st
on st.student_id = e.student_id
where st.student_id = 7
order by course asc;
-- Q7!!!!!!!!!!!!!!!!
select term, year, count(e.student_id) as "Enrollment"
from term as t
left join section as s
on t.term_id = s.term_id
left join enrolment as e
on s.section_id = e.section_id
where s.term_id = 1
group by year, term;

-- Q8
select college_name, count(co.department_id) as "Courses"
from college as c
left join department as d
on c.college_id = d.college_id
left join course as co
on co.department_id = d.department_id
group by college_name
order by college_name asc;
-- Q9
select distinct fname, lname, sum(capacity) as "TeachingCapacity"
from section as s
left join faculty as f
on s.faculty_id = f.faculty_id
where term_id = 2
group by fname, lname
order by TeachingCapacity;
-- Q10   
select distinct lname, fname, sum(credits)
from student as s
left join enrolment as e
on s.student_id = e.student_id
left join section as se
on se.section_id = e.section_id
left join course as c
on c.course_id = se.course_id
where term_id = 1
group by lname, fname
having sum(credits) > 3
order by sum(credits) desc;

