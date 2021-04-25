import * as coreui from '@coreui/coreui'
import $ from 'jquery'
import select2 from 'select2'

document.addEventListener("turbo:load", function() {
  document.querySelectorAll('[data-tooltip="true"]').forEach(el => { new coreui.Tooltip(el) })
  document.querySelectorAll('.alert').forEach(el => { new coreui.Alert(el) })
  $('.select2-init').select2()
})
