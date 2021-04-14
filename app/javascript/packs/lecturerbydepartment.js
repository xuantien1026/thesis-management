import $ from 'jquery'
/*function showlecturerbydepartment(id){
    $.ajax({
        url: "/lecturerbydepartment",
        method: "GET",
        dataType: "json",
        data: {department: id},
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            $('#lecturertable tbody').empty();
            jQuery.each(response, function(i,data) {
                $("#lecturertable").append(
                    "<tr>"+
                    "<td>" + data.mscb + "</td>"+
                    "<td>" + data.name + "</td>"+
                    "<td>" + data.email + "</td>"+
                    "</tr>"
                );
            });
        }
    });
} */


$(document).on('turbolinks:load', function() {
    console.log("It works on each visit!")
})
/*v
import $ from 'jquery'
$("#departmentselector").change(function () {
    console.log("okkkk");
    var department = $(this).val();
    $.ajax({
        url: "/lecturerbydepartment",
        method: "GET",
        dataType: "json",
        data: {department: department},
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log("okkkk");
            var lecturerbydepartment = response["lecturerBydDepartment"];
            console.log(lecturerbydepartment);

        }
    });
});
 */