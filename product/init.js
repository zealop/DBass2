

$(document).ready(function() {
	var col = ['ProductID', 'ProductName', 'ProductPrice', 'ProductStock', 'ProductDesc', 'ProductImage'];
    //Grab data from table
    $.get("./init.php", function(data, status) {
        var data_list = data;
        for (var i = 0; i < data_list.length; i++) {
            var data = '<tr data-id="' + data_list[i].ProductID +
                '" data-name="' + data_list[i].ProductName +
                '" data-price="' + data_list[i].ProductPrice +
                '" data-stock="' + data_list[i].ProductStock +
                '" data-desc="' + data_list[i].ProductDesc +
                '" data-img="' + data_list[i].ProductImage + '">' +
                '<td>' + data_list[i][col[0]] + "</td>" +
                "<td>" + data_list[i].ProductName + "</td>" +
                "<td>" + data_list[i].ProductPrice + "</td>" +
                "<td>" + data_list[i].ProductStock + "</td>" +
                "<td>" + data_list[i].ProductDesc + "</td>" +
                "<td>" + data_list[i].ProductImage + "</td>" +
                "<td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td>" +
                "</tr>"
            $("#mytbody").append(data);
        }
        $('#mytable').DataTable();
        $('.dataTables_length').addClass('bs-select');
    });

    //add
    $("form").submit(function(e) {
        e.preventDefault();
        var id = $("input[name='id']").val();
        var name = $("input[name='name']").val();
        var price = $("input[name='price']").val();
		var stock = $("input[name='stock']").val();
        var desc = $("input[name='desc']").val();
        var img = $("input[name='img']").val();
		
        var data = {
            id: id,
            name: name,
            price: price,
			stock: stock,
			desc: desc,
			img: img
        }
        console.log(data);
        $.ajax({
            type: "POST",
            url: './add.php',
            processData: false,
            contentType: 'application/json',
			dataType: 'text',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
                if (response.trim() == 'New record added') {
                    $("#mytbody").append("<tr data-id=" + id + 
											" data-name=" + name + 
											" data-price=" + price +
											" data-stock=" + stock +
											" data-desc=" + desc +
											" data-img=" + img +
											"><td>" + id + 
											"</td><td>" + name + 
											"</td><td>" + price + 
											"</td><td>" + stock + 
											"</td><td>" + desc + 
											"</td><td>" + img + 
											"</td><td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>");
                    $("input[name='id']").val('');
                    $("input[name='name']").val('');
                    $("input[name='price']").val('');
					$("input[name='stock']").val('');
					$("input[name='desc']").val('');
					$("input[name='img']").val('');
                } 
                alert(response);
            },
            error: function(response) {
                console.log(response);
            }
        });
    });


    //delete
    $("body").on("click", ".btn-delete", function() {
        var id = $(this).parents("tr").find("td:eq(0)").html();
        var name = $(this).parents("tr").find("td:eq(1)").html();
        var price = $(this).parents("tr").find("td:eq(2)").html();
		var stock = $(this).parents("tr").find("td:eq(3)").html();
        var desc = $(this).parents("tr").find("td:eq(4)").html();
        var img = $(this).parents("tr").find("td:eq(5)").html();
		var ref = $(this);
		
        var data = {
            id: id,
            name: name,
            price: price,
			stock: stock,
			desc: desc,
			img: img
        }
        $.ajax({
            type: "POST",
            url: './remove.php',
            processData: false,
			dataType: 'text',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
				if(response.trim() == "Record deleted"){
					ref.parents("tr").remove();
				}
				else
					alert(response);
            },
            error: function(response) {
                console.log(response);
            }
        });
        
    });

    //edit
    $("body").on("click", ".btn-edit", function() {
        var name = $(this).parents("tr").attr('data-name');
        var price = $(this).parents("tr").attr('data-price');
		var stock = $(this).parents("tr").attr('data-stock');
        var desc = $(this).parents("tr").attr('data-desc');
		var img = $(this).parents("tr").attr('data-img');

        $(this).parents("tr").find("td:eq(1)").html('<input name="edit_name" value="' + name + '" required>');
        $(this).parents("tr").find("td:eq(2)").html('<input name="edit_price" value="' + price + '" required>');
		$(this).parents("tr").find("td:eq(3)").html('<input name="edit_stock" value="' + stock + '" required>');
        $(this).parents("tr").find("td:eq(4)").html('<input name="edit_desc" value="' + desc + '" required>');
		$(this).parents("tr").find("td:eq(5)").html('<input name="edit_img" value="' + img + '">');

        $(this).parents("tr").find("td:eq(6)").prepend("<button class='btn btn-info btn-xs btn-update'>Update</button><button class='btn btn-warning btn-xs btn-cancel'>Cancel</button>")
        $(this).hide();
    });

    //cancel
    $("body").on("click", ".btn-cancel", function() {
        var name = $(this).parents("tr").attr('data-name');
        var price = $(this).parents("tr").attr('data-price');
		var stock = $(this).parents("tr").attr('data-stock');
        var desc = $(this).parents("tr").attr('data-desc');
		var img = $(this).parents("tr").attr('data-img');

        $(this).parents("tr").find("td:eq(1)").text(name);
        $(this).parents("tr").find("td:eq(2)").text(price);
		$(this).parents("tr").find("td:eq(3)").text(stock);
        $(this).parents("tr").find("td:eq(4)").text(desc);
		$(this).parents("tr").find("td:eq(5)").text(img);

        $(this).parents("tr").find(".btn-edit").show();
        $(this).parents("tr").find(".btn-update").remove();
        $(this).parents("tr").find(".btn-cancel").remove();
    });

    //update
    $("body").on("click", ".btn-update", function() {
        var id = $(this).parents("tr").find("td:eq(0)").html();
        var name = $(this).parents("tr").find("input[name='edit_name']").val();
        var price = $(this).parents("tr").find("input[name='edit_price']").val();
		var stock = $(this).parents("tr").find("input[name='edit_stock']").val();
        var desc = $(this).parents("tr").find("input[name='edit_desc']").val();
        var img = $(this).parents("tr").find("input[name='edit_img']").val();
        var ref = $(this);
        var data = {
            id: id,
            name: name,
            price: price,
			stock: stock,
			desc: desc,
			img: img
        }
		
        $.ajax({
            type: "POST",
            url: './update.php',
            processData: false,
			dataType: 'text',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function() {
                console.log('Sending AJAX Request...');
            },
            success: function(response) {
                console.log(response);
                if (response.trim() == "Record updated") {

                    ref.parents("tr").find("td:eq(1)").text(name);
                    ref.parents("tr").find("td:eq(2)").text(price);
					ref.parents("tr").find("td:eq(3)").text(stock);
                    ref.parents("tr").find("td:eq(4)").text(desc);
					ref.parents("tr").find("td:eq(5)").text(img);

                    ref.parents("tr").attr('data-name', name);
                    ref.parents("tr").attr('data-price', price);
					ref.parents("tr").attr('data-stock', stock);
                    ref.parents("tr").attr('data-desc', desc);
					ref.parents("tr").attr('data-img', img);

                    ref.parents("tr").find(".btn-edit").show();
                    ref.parents("tr").find(".btn-cancel").remove();
                    ref.parents("tr").find(".btn-update").remove();
                }
                alert(response);
                
            },
            error: function(response) {
                console.log(response);
            }
        });
    });
});
//sidebar
jQuery(function($) {

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