import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["numberOfCommittees", "thesisGroup"]

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
    alert('Tách hội đồng thành công, mời thầy/cô kiểm tra, chỉnh sửa và nhấn "Xem danh sách hội đồng"')
  }

  assignCommittee(thesisGroup, committeeNumber) {
    let inputs = thesisGroup.getElementsByClassName('committee-input')
    for (let input of inputs) { input.value = committeeNumber }
  }
}
