import * as coreui from '@coreui/coreui'
import $ from 'jquery'
import select2 from 'select2'

document.addEventListener("turbo:load", function() {
  document.querySelectorAll('[data-tooltip="true"]').forEach(el => { new coreui.Tooltip(el) })
  document.querySelectorAll('[data-toggle="modal"]').forEach(el => { new coreui.Modal(el) })
  document.querySelectorAll('.alert').forEach(el => { new coreui.Alert(el) })
  new coreui.Sidebar(document.querySelector('#sidebar'))
  $('.select2-init').select2()
})
