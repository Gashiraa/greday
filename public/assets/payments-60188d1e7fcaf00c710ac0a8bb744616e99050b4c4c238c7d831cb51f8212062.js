$(document).on("turbolinks:load",function(){$("#customer_select_invoice").on("focus load trigger mouseover change",function(){let e=this.options[this.selectedIndex].value;$("#select_invoices_payment > option").each(function(){this.getAttribute("invoice")===e?this.style.display="block":this.style.display="none"})}),$("#customer_select_invoice").trigger("change")});