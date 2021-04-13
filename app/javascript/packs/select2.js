import $ from 'jquery'
import select2 from 'select2'

const majors = $("#thesis_proposal_majors")
majors.select2()

const numberOfStudent = $("#topic_number_of_students")
const studentSelectBox = $(".student-select-box")

const initializeSelect2 = (selectionLength) => {
  $(".student-select-box").select2({
    maximumSelectionLength: selectionLength
  })
}

numberOfStudent.change(() => {
  studentSelectBox.val("")
  initializeSelect2(numberOfStudent.val())
})

initializeSelect2(numberOfStudent.val())



