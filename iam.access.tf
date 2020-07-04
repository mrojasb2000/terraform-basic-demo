resource "aws_iam_group" "group-admins" {
  name = "group-admins"
}

resource "aws_iam_policy_attachment" "admins-attach" {
    name = "admins-attach"
    groups = ["${aws_iam_group.group-admins.name}"]
    policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}

resource "aws_iam_user" "user-admin-1" {
    name = "user_admin_1"
}

resource "aws_iam_user" "user-admin-2" {
    name = "user_admin_2"
}

resource "aws_iam_group_membership" "admins_users" {
    name = "admin-users"
    users = [
        "${aws_iam_user.user-admin-1.name}", 
        "${aws_iam_user.user-admin-2.name}",
    ]
    group = aws_iam_group.group-admins.name
}

resource "aws_iam_access_key" "user-admin-access-1" {
    user = aws_iam_user.user-admin-1.name
}

resource "aws_iam_access_key" "user-admin-access-2" {
    user = aws_iam_user.user-admin-2.name
}

output "user_admin_access_1" {
    value = "${aws_iam_access_key.user-admin-access-1.id}"
}

output "user_admin_secret_1" {
    value = "${aws_iam_access_key.user-admin-access-1.secret}"
}

output "user_admin_access_2" {
    value = "${aws_iam_access_key.user-admin-access-2.id}"
}

output "user_admin_secret_2" {
    value = "${aws_iam_access_key.user-admin-access-2.secret}"
}