import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["numberOfCommittees", "thesisGroup", "buttons"]

  addMember() {
    let committeeIndex = this.element.dataset.index
    let newMemberIndex = Date.now()

    let newRow = this.element.firstChild.cloneNode(true)

    let newLecturerSelect = this.lecturerSelect(committeeIndex, newMemberIndex)
    newRow.firstChild.replaceChildren(newLecturerSelect)

    let roleInput = newRow.lastChild.firstChild
    roleInput.name = `defense_committee_form[defense_committees_attributes][${committeeIndex}][defense_committee_members_attributes][${newMemberIndex}][role]`

    this.element.insertBefore(newRow, this.buttonsTarget)
  }

  lecturerSelect(committeeIndex, newMemberIndex) {
    let allLecturers = JSON.parse(document.getElementById('all-lecturers').innerText)

    let selectInput = document.createElement('select')
    selectInput.name = `defense_committee_form[defense_committees_attributes][${committeeIndex}][defense_committee_members_attributes][${newMemberIndex}][lecturer_id]`
    selectInput.className = 'form-control'
    allLecturers.forEach(lecturer => {
      let option = document.createElement('option')
      option.value = lecturer[1]
      option.text = lecturer[0]
      selectInput.appendChild(option)
    })
    return selectInput
  }

  suggest() {
    let numberOfCommittees = this.numberOfCommitteesTarget.value
    if (!numberOfCommittees) { alert('Nhập số lượng Hội Đồng Bảo Vệ!'); return; }

    let numberOfTheses = document.getElementsByClassName('committee-input').length
    let thesesPerCommittee = Math.ceil(numberOfTheses / numberOfCommittees)

    let currentCommittee = 1
    let currentThesisCount = 0
    this.thesisGroupTargets.forEach(group => {
      if (currentCommittee == numberOfCommittees) { this.assignCommittee(group, currentCommittee); return; }

      let thesesInThisGroup = group.getElementsByClassName('committee-input').length

      if (currentThesisCount + thesesInThisGroup > thesesPerCommittee) {
        currentCommittee += 1
        currentThesisCount = 0
      }
      this.assignCommittee(group, currentCommittee)
      currentThesisCount += thesesInThisGroup
    })
    alert('Tách thành công, mời thầy/cô kiểm tra, chỉnh sửa và nhấn "Xem danh sách hội đồng"')
  }

  assignCommittee(thesisGroup, committeeNumber) {
    let inputs = thesisGroup.getElementsByClassName('committee-input')
    for (let input of inputs) { input.value = committeeNumber }
  }
}
