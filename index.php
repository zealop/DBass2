<!DOCTYPE html>
<html>
<head>
  <title>DBass2</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
</head>
<body>
	<?php
		$connect = mysqli_connect("localhost", "root", "", "examples");
		if (!$connect) {
			die("Connection failed: " . mysqli_connect_error());
		}
		$query = "SELECT id,name,year FROM cars";
		$result = mysqli_query($connect, $query);
	?>
	<div class="container">
		<h1>DBass2</h1>
		<form method="post" action="">
            
			<div class="form-group">
				<label>ID:</label>
				<input type="text" name="id" id="id" class="form-control" value="4" required="">
			</div>
			
			<div class="form-group">
				<label>Name:</label>
				<input type="text" name="name" id="name" class="form-control" value="Mercedes" required="">
			</div>
	
			<div class="form-group">
				<label>Year:</label>
				<input type="text" name="year" id="year" class="form-control" value="1972" required="">
			</div>
   
			<button type="submit" class="btn btn-success save-btn" name="add">Add</button>
		</form>
		
		<br/>
		<table class="table table-bordered data-table" id="mytable">
			<thead>
				<th width="50px">ID</th>
				<th width="200px">Name</th>
				<th width="200px">Year</th>
				<th width="200px">Action</th>
			</thead>
			<tbody>
				<?php
					while($row = mysqli_fetch_array($result)){
						echo '<tr data-id='.$row["id"].' data-name='.$row["name"].' data-year='.$row["year"].'> 
							<td>'.$row["id"].'</td>
							<td>'.$row["name"].'</td>
							<td>'.$row["year"].'</td>
							<td><button class="btn btn-info btn-xs btn-edit">Edit</button><button class="btn btn-danger btn-xs btn-delete">Delete</button></td>
						</tr>';
					}
				?>
			</tbody>
		</table>
	</div>
	
	<script type="text/javascript">
   
		$("form").submit(function(e){
			e.preventDefault();
			var id = $("input[name='id']").val();
			var name = $("input[name='name']").val();
			var year = $("input[name='year']").val();
			
			var dataString = 'id1=' + id + '&name1=' + name + '&year1=' + year;
			$.ajax({
				type: "POST",
				url:'add.php',
				data: dataString,
				success: function(response){
					console.log(response);
					$(".result").html(response +"\r\n");
					if(response == 'New record added'){
						var table = document.getElementById('mytable');
						$(".data-table tbody").append("<tr data-id="+id+" data-name="+name+" data-year="+year+"><td>"+id+"</td><td>"+name+"</td><td>"+year+"</td><td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>");
						$("input[name='id']").val('');
						$("input[name='name']").val('');
						$("input[name='year']").val('');
					}
				},
				error: function(){
					console.log('Request Failed.');
				}
			});
		});
   
		$("body").on("click", ".btn-delete", function(){
			var id = $(this).parents("tr").find("td:eq(0)").html();
			var dataString = 'id1=' + id;
			$.ajax({
				type: "POST",
				url:'remove.php',
				data: dataString,
				beforeSend: function(){
					console.log('Sending AJAX Request...');
				},
				success: function(response){
					console.log(response);
					$(".result").html(response);
				},
				error: function(){
					console.log('Request Failed.');
				}
			});
			$(this).parents("tr").remove();
		});
    
		$("body").on("click", ".btn-edit", function(){
			var name = $(this).parents("tr").attr('data-name');
			var year = $(this).parents("tr").attr('data-year');
    
			$(this).parents("tr").find("td:eq(1)").html('<input name="edit_name" value="'+name+'" required>');
			$(this).parents("tr").find("td:eq(2)").html('<input name="edit_year" value="'+year+'">');
		
			$(this).parents("tr").find("td:eq(3)").prepend("<button class='btn btn-info btn-xs btn-update'>Update</button><button class='btn btn-warning btn-xs btn-cancel'>Cancel</button>")
			$(this).hide();
		});
   
		$("body").on("click", ".btn-cancel", function(){
			var name = $(this).parents("tr").attr('data-name');
			var year = $(this).parents("tr").attr('data-year');
    
			$(this).parents("tr").find("td:eq(1)").text(name);
			$(this).parents("tr").find("td:eq(2)").text(year);
   
			$(this).parents("tr").find(".btn-edit").show();
			$(this).parents("tr").find(".btn-update").remove();
			$(this).parents("tr").find(".btn-cancel").remove();
		});
   
		$("body").on("click", ".btn-update", function(){
			var id = $(this).parents("tr").find("td:eq(0)").html();
			var name = $(this).parents("tr").find("input[name='edit_name']").val();
			var year = $(this).parents("tr").find("input[name='edit_year']").val();
    
			var dataString = 'id1=' + id + '&name1=' + name + '&year1=' + year;
			
			$(this).parents("tr").find("td:eq(1)").text(name);
			$(this).parents("tr").find("td:eq(2)").text(year);
			
			$(this).parents("tr").attr('data-name', name);
			$(this).parents("tr").attr('data-year', year);
			
			$(this).parents("tr").find(".btn-edit").show();
			$(this).parents("tr").find(".btn-cancel").remove();
			$(this).parents("tr").find(".btn-update").remove();
						
			$.ajax({
				type: "POST",
				url:'update.php',
				data: dataString,
				beforeSend: function(){
					console.log('Sending AJAX Request...');
				},
				success: function(response){
					console.log(response);
					$(".result").html(response);
					if(response == 'Record updated'){
					}
				},
				error: function(){
					console.log('Request Failed.');
				}
			});
		});
		
	</script>
	<div class="container">
		<p class="result" id="result"></p>
	</div>
	<?php mysqli_close($connect) ?>
</body>
</html>