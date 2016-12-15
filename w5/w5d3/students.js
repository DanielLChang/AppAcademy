function Course(name, dept, credits, days, block) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.studentList = [];
  this.days = days;
  this.block = block;
}

Course.prototype.students = function() {
  return this.studentList;
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(other) {
  if (this.block !== other.block) {
    return false;
  }

  for (let i = 0; i < this.days.length; i++) {
    if (other.days.indexOf(this.days[i]) !== -1) {
      return true;
    }
  }

  return false;
};

function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courseList = [];
}

Student.prototype.name = function() {
  return `${this.fname} ${this.lname}`;
};

Student.prototype.courses = function() {
  return this.courseList;
};

Student.prototype.enroll = function(course) {
  if (!this.hasConflict(course)) {
    this.courseList.push(course);
    course.studentList.push(this);
  } else {
    throw "error!";
  }
};

Student.prototype.hasConflict = function(otherCourse) {
  for (let i = 0; i < this.courseList.length; i++) {
    if (this.courseList[i].conflictsWith(otherCourse)) {
      return true;
    }
  }
  return false;
};

let student1 = new Student("first", "last");
let course1 = new Course("ochem", "chemistry", 3, ['m', 'w', 'f'], 4);
let course2 = new Course("genchem", "chemistry", 2, ['m', 'w', 'f'], 4);

// console.log(course1.conflictsWith(course2));
course1.addStudent(student1);
console.log(student1.hasConflict(course2));
course2.addStudent(student1);
//
// console.log(student1.courses());
// console.log(course1.students());
// console.log(student1.name());
// console.log(student1.courses());
