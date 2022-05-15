<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}




h2{
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}






input[type=text], select {
width: 100%;
padding: 12px 20px;
margin: 8px 0;
display: inline-block;
border: 1px solid #ccc;
border-radius: 4px;
box-sizing: border-box;
}





input[type=submit] {
width: 100%;
background-color: #4CAF50;
color: white;
padding: 14px 20px;
margin: 8px 0;
border: none;
border-radius: 4px;
cursor: pointer;
}





input[type=submit]:hover {
background-color: #45a049;
}





div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}




</style>

<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <h1>Unit Management List</h1>
	                    <div>
	                        <div id="usersDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
 	<h1>Unit Management List</h1>
    <form id="userRegister">
    <input type="hidden" id="edit_id" name="edit_id">
          						 <div>
	                                <label>Account ID</label>
	                                <div>
	                                    <input type="text" id="accountId" class="form-control" name="accountId">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Number of Units</label>
	                                <div>
	                                    <input type="number" id="numberOfUnits" class="form-control" name="numberOfUnits">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>From date</label>
	                                <div>
	                                    <input type="date" id="fromDate" class="form-control" name="fromDate">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>To date</label>
	                                <div>
	                                    <input type="date" id="toDate" class="form-control" name="toDate">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill Amount</label>
	                                <div>
	                                    <input type="text" id="billAmount" class="form-control" name="billAmount">
	                                </div>
	                            </div>
          
					          <div>
					              <input type="submit" value="Edit">
					          </div>
  	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest_api/unit",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="Done"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

    $(document).ready(function () {

        $("#userRegister").validate({
        	rules: {
        		accountId: "required",
            	numberOfUnits: "required",
            	fromDate: "required",
            	toDate: "required",
            	billAmount: "required"
            },
            messages: {
            	accountId: "required",
            	numberOfUnits: "required",
            	fromDate: "required",
            	toDate: "required",
            	billAmount: "required"
            },
            submitHandler: function () {
            	var fromData = JSON.stringify({
            		"id" : $('#edit_id').val(),
            		 "account_number" : $('#accountId').val(),
                     "units" : $('#numberOfUnits').val(),
                     "f_date" : $('#fromDate').val(),
                     "t_date" : $('#toDate').val(),
                     "amount" : $('#billAmount').val()
                });
            	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'rest_api/unit',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="Done"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#userRegister")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#userRegister").submit(function(e) {
            e.preventDefault();
        });

    });

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest_api/unit",
            success: function(data){
            	$("#usersDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest_api/unit/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#accountId').val(data['account_number']),
                $('#numberOfUnits').val(data['units']),
                $('#fromDate').val(data['f_date']),
                $('#toDate').val(data['t_date']),
                $('#billAmount').val(data['amount'])
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
        
    }
    
    
</script>