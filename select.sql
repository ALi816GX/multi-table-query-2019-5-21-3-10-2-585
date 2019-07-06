# 1.查询同时存在1课程和2课程的情况
# 2.查询同时存在1课程和2课程的情况
select st.name from student_course sc,student st
where sc.courseId in(select courseId from course where courseId ='1' or courseId='2') 
and sc.studentId = st.id group by name having count(sc.score)= 2

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select s.id ,s.name, cast(avg(sc.score) as decimal(18,2)) avg_score from student s, student_course sc
where s.id = sc.studentId group by s.id,s.name
having cast(avg(sc.score) as decimal(18,2)) >= 60


# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select st.id, st.name,st.age,st.sex from student st left join student_course sc
on st.id = sc.studentId group by st.id, st.name,st.age,st.sex
having ifnull(cast(avg(sc.score) as decimal(18,2)),0) = 0

# 5.查询所有有成绩的SQL
select st.id,st.`name`,c.`name` c_name, sc.score
from student st, student_course sc, course c
where st.id = sc.studentId and sc.courseId =c.id
group by st.id,st.`name`,c.`name`, sc.score
order by st.id,st.`name`,c.`name`, sc.score

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select id,name,age,sex from student_course sc,student st
where sc.courseId in(select courseId from course where courseId ='1' or courseId='2') 
and sc.studentId = st.id group by id,name,age,sex having count(sc.score)= 2

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select st.* , sc.courseID , sc.score from student st, student_course sc
where st.id = sc.studentId and sc.score < 60 and sc.courseID = '1'
order by sc.score desc

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select c.id,c.name,cast(avg(sc.score) as decimal(18,2)) avg_score
from student_course sc, course c
where sc.courseId = c.id  
group by c.id,c.name
order by avg_score desc, c.id asc

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select st.name, sc.score from student st,student_course sc,course c
where st.id = sc.studentId and sc.courseId = c.id and c.name = '数学' and score < 60
