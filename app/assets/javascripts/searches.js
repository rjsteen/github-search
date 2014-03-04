

$(document).ready(function(){

	//set up datatables
	$('.datatable').dataTable({
		 "iDisplayLength": 10,
   		 "aLengthMenu": [[10, 20, 50, 100], [10, 20, 50, 100]],
          bProcessing: true,
          bServerSide: true,
          sAjaxSource: $('#searches').data('source'),
          "sPaginationType": "full_numbers",
          aoColumnDefs: [
          { 'bSortable': false, 'aTargets': [ 0, 1 ] }
       	  ]


	}).fnFilterOnReturn().columnFilter({ sPlaceHolder: "head:before",
		aoColumns: [ null, {type: 'text'}]
	});
	//prevent github limits (1000)
	
	$(".last.paginate_button").hide();


});