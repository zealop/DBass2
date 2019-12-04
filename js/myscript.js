$(document).ready(function(){
	//Grab data from table
	$.get("/DBass2/php/init.php", function(data, status){
		var cars_list = JSON.parse(data)
		for(var i = 0; i < cars_list.length; i++){
			var car =	"<tr data-id=\"" + cars_list[i].id + "\" data-name=\"" + cars_list[i].name + "\" data-year=\"" + cars_list[i].year + "\">" +
							"<td>" + cars_list[i].id + "</td>" +
							"<td>" + cars_list[i].name + "</td>" +
							"<td>" + cars_list[i].year + "</td>" +
							"<td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td>"
						+ "</tr>"
			$("#mytbody").append(car);
		}
		$('#mytable').DataTable();
		$('.dataTables_length').addClass('bs-select');
	});
	
	
	
	//add
	$("form").submit(function(e){
		e.preventDefault();
		var id = $("input[name='id']").val();
		var name = $("input[name='name']").val();
		var year = $("input[name='year']").val();
		
		var car = {
			id: id,
			name: name,
			year: year
		}
		console.log(car);
		$.ajax({
			type: "POST",
			url:'/DBass2/php/add.php',
			processData: false,
			contentType: 'application/json',
			data: JSON.stringify(car),
			beforeSend: function(){
				console.log('Sending AJAX Request...');
			},
			success: function(response){
				console.log(response);
				if(response.trim() == 'New record added'){
					$("#mytbody").append("<tr data-id="+id+" data-name="+name+" data-year="+year+"><td>"+id+"</td><td>"+name+"</td><td>"+year+"</td><td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>");
					$("input[name='id']").val('');
					$("input[name='name']").val('');
					$("input[name='year']").val('');
				}
				else{
					alert(response);
				}
			},
			error: function(response){
				console.log('Request Failed.');
			}
		});
	});


	//delete
	$("body").on("click", ".btn-delete", function(){
		var id = $(this).parents("tr").find("td:eq(0)").html();
		var name = $(this).parents("tr").find("td:eq(1)").html();
		var year = $(this).parents("tr").find("td:eq(2)").html();
		
		var car = {
			id: id,
			name: name,
			year: year
		}
		$.ajax({
			type: "POST",
			url:'/DBass2/php/remove.php',
			processData: false,
			contentType: 'application/json',
			data: JSON.stringify(car),
			beforeSend: function(){
				console.log('Sending AJAX Request...');
			},
			success: function(response){
				console.log(response);
			},
			error: function(response){
				console.log('Request Failed.');
			}
		});
		$(this).parents("tr").remove();
	});

	//edit
	$("body").on("click", ".btn-edit", function(){
		var name = $(this).parents("tr").attr('data-name');
		var year = $(this).parents("tr").attr('data-year');

		$(this).parents("tr").find("td:eq(1)").html('<input name="edit_name" value="'+name+'" required>');
		$(this).parents("tr").find("td:eq(2)").html('<input name="edit_year" value="'+year+'">');

		$(this).parents("tr").find("td:eq(3)").prepend("<button class='btn btn-info btn-xs btn-update'>Update</button><button class='btn btn-warning btn-xs btn-cancel'>Cancel</button>")
		$(this).hide();
	});

	//cancel
	$("body").on("click", ".btn-cancel", function(){
		var name = $(this).parents("tr").attr('data-name');
		var year = $(this).parents("tr").attr('data-year');

		$(this).parents("tr").find("td:eq(1)").text(name);
		$(this).parents("tr").find("td:eq(2)").text(year);

		$(this).parents("tr").find(".btn-edit").show();
		$(this).parents("tr").find(".btn-update").remove();
		$(this).parents("tr").find(".btn-cancel").remove();
	});

	//update
	$("body").on("click", ".btn-update", function(){
		var id = $(this).parents("tr").find("td:eq(0)").html();
		var name = $(this).parents("tr").find("input[name='edit_name']").val();
		var year = $(this).parents("tr").find("input[name='edit_year']").val();
		var ref = $(this);
		var car = {
			id: id,
			name: name,
			year: year
		}
					
		$.ajax({
			type: "POST",
			url:'/DBass2/php/update.php',
			processData: false,
			contentType: 'application/json',
			data: JSON.stringify(car),
			beforeSend: function(){
				console.log('Sending AJAX Request...');
			},
			success: function(response){
				console.log(response);
				if(response.trim() == "Record updated"){
					
					ref.parents("tr").find("td:eq(1)").text(name);
					ref.parents("tr").find("td:eq(2)").text(year);
					
					ref.parents("tr").attr('data-name', name);
					ref.parents("tr").attr('data-year', year);
					
					ref.parents("tr").find(".btn-edit").show();
					ref.parents("tr").find(".btn-cancel").remove();
					ref.parents("tr").find(".btn-update").remove();
				}
				else{
					alert(response);
				}
			},
			error: function(){
				console.log('Request Failed.');
			}
		});
	});
});
jQuery(function ($) {

    $(".sidebar-dropdown > a").click(function() {
  $(".sidebar-submenu").slideUp(200);
  if (
    $(this)
      .parent()
      .hasClass("active")
  ) {
    $(".sidebar-dropdown").removeClass("active");
    $(this)
      .parent()
      .removeClass("active");
  } else {
    $(".sidebar-dropdown").removeClass("active");
    $(this)
      .next(".sidebar-submenu")
      .slideDown(200);
    $(this)
      .parent()
      .addClass("active");
  }
});

$("#close-sidebar").click(function() {
  $(".page-wrapper").removeClass("toggled");
});
$("#show-sidebar").click(function() {
  $(".page-wrapper").addClass("toggled");
});


   
   
});