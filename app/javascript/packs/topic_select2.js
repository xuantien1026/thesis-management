import $ from 'jquery'
import select2 from 'select2'

const maxStudentCount = $("#topic_max_student_count")
const studentSelectBox = $(".student-select-box")

const initializeSelect2 = (selectionLength) => {
  $(".student-select-box").select2({
    maximumSelectionLength: selectionLength
  })
}

maxStudentCount.change(() => {
  studentSelectBox.val("")
  initializeSelect2(maxStudentCount.val())
})

initializeSelect2(maxStudentCount.val())



