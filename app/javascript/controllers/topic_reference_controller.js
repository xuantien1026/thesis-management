import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "referenceList", "reference" ]

  addReference() {
    const newReference = this.referenceTarget.cloneNode(true)
    newReference.querySelector("input").value = ""
    this.referenceListTarget.append(newReference)
  }

  removeReference(event) {
    if (this.referenceTargets.length == 1) return
    event.target.closest('[data-topic-reference-target="reference"]').remove()
  }
}
