import * as coreui from '@coreui/coreui'
import $ from 'jquery'
import select2 from 'select2'

document.querySelectorAll('[data-tooltip="true"]').forEach(el => { new coreui.Tooltip(el) })
document.querySelectorAll('.alert').forEach(el => { new coreui.Alert(el) })
document.querySelectorAll('[data-toggle="dropdown"]').forEach(el => { new coreui.Dropdown(el) })
$('.select2').select2()
