import { Controller } from "stimulus"
import $ from 'jquery'
import select2 from 'select2'
import 'select2-bootstrap-theme/dist/select2-bootstrap.min.css'

export default class extends Controller {
  connect() {
    console.log("controller connected")
    $(this.element).select2({
      theme: 'bootstrap'
    })
  }
}
