
function calc_avg(total, count) {
    return total / count
}

BEGIN {
    FS = ","
    print "Processing student grades...\n"
}

NR == 1 {
    num_subjects = NF - 2
    next
}

{
    student_id = $1
    name = $2
    total = 0

    for (i = 3; i <= NF; i++) {
        total += $i
    }

    avg = calc_avg(total, num_subjects)
    status = (avg >= 70) ? "Pass" : "Fail"

    total_score[name] = total
    average_score[name] = avg
    student_status[name] = status
    student_list[NR] = name

    if (NR == 2 || total > max_score) {
        max_score = total
        top_student = name
    }
    if (NR == 2 || total < min_score) {
        min_score = total
        low_student = name
    }
}

END {
    for (i = 2; i <= NR; i++) {
        name = student_list[i]
        printf("Student: %s\n", name)
        printf("  Total: %d\n", total_score[name])
        printf("  Average: %.2f\n", average_score[name])
        printf("  Status: %s\n\n", student_status[name])
    }

    print "Top scoring student: " top_student " (" max_score ")"
    print "Lowest scoring student: " low_student " (" min_score ")"
}
