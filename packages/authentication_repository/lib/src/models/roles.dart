enum Roles {
  student,
  teacher,
  admin,
}

String getRoleFromEnum(Roles role) {
  switch (role) {
    case Roles.student:
      return "student";
    case Roles.teacher:
      return "teacher";
    case Roles.admin:
      return "admin";
  }
}
