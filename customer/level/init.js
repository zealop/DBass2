//column name in database
var col = ['CustomerID', 'Fullname', 'Level']
//column name on web page
var abr = ['ID', 'Name', 'Level'];

(function ($) {
    $.fn.serializeFormJSON = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };
})(jQuery);
//Turn row in to JSON except last column
(function ($) {
    $.fn.serializeRowJSON = function () {
		var o ={};
		var headers = $(this).parents("table").find("th");
		$(this).parents("tr").find("td").not(':last').each(function(cellIndex) {
			o[$(headers[cellIndex]).html()] = $(this).html();
		});    
		return o;
	};
}) (jQuery);



$(document).ready(function() {	
	$.get("./init.php", function(data, status) {
        var data_list = data;
        for (var i = 0; i < data_list.length; i++) {
			var data = '<tr>';
			for (var j=0; j < col.length;j++){
				if(String(data_list[i][col[j]]) == 'null')
					temp = '';
				else
					temp = data_list[i][col[j]];
				data += '<td>' + temp + "</td>";
			}
            $("#mytbody").append(data);
        }
        $('#mytable').DataTable();
        $('.dataTables_length').addClass('bs-select');
    });
});
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


