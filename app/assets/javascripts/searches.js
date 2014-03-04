

$(document).ready(function(){

	//set up datatables
	$('.datatable').dataTable({
		"sDom": '<"top"f>rt<"bottom"p><"clear">',
		 "iDisplayLength": 10,
   		 "aLengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]],
          bProcessing: true,
          bServerSide: true,
          sAjaxSource: $('#searches').data('source'),
          "sPaginationType": "full_numbers",
          aoColumnDefs: [
          { 'bSortable': false, 'aTargets': [ 0, 1 ] }
       	  ]


	}).columnFilter({ sPlaceHolder: "head:before",
		aoColumns: [ null, {type: 'text'}]
	}).fnSetFilteringDelay(250);
	//prevent github limits
	
	$(".last.paginate_button").hide();


});