import * as coreui from '@coreui/coreui'

document.querySelectorAll('[data-tooltip="true"]').forEach(el => { new coreui.Tooltip(el) })