$(document).on("turbolinks:load",function(){$("#invoice_form_customer").select2({theme:"bootstrap",width:"100%",selectOnClose:!0,language:$(".locale").data("locale")}),$("#invoice_form_number").select2({theme:"bootstrap",width:"100%",tags:!0,selectOnClose:!0,language:$(".locale").data("locale")}),$("#invoice_form_customer").on("focus load trigger mouseover change",function(){let e=this.options[this.selectedIndex].value;$("#invoice_form_wares > option").each(function(){this.getAttribute("customer")===e?this.style.display="block":this.style.display="none"}),$("#invoice_form_projects > option").each(function(){this.getAttribute("customer")===e?this.style.display="block":this.style.display="none"})}),$("#invoice_form_customer").trigger("change"),$("#project-customer-id").data("somedata")&&($("#invoice_form_customer").val([$("#project-customer-id").data("somedata")]),$("#invoice_form_customer").select2({theme:"bootstrap",width:"100%",selectOnClose:!0}).trigger("change"))});